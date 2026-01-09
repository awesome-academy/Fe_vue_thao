# frozen_string_literal: true

class OAuthService
  require 'google/auth/stores/file_token_store'
  require 'google/apis/people_v1'

  def authenticate_google(id_token)
    # Verify ID token
    payload = verify_google_token(id_token)

    return Result.new(false, nil, ['Invalid Google token']) unless payload

    google_uid = payload['sub']
    email = payload['email']
    full_name = payload['name']
    picture_url = payload['picture']

    # Find or create user
    user = User.find_by(google_uid:) || create_user_from_google(google_uid,
                                                                email,
                                                                full_name,
                                                                picture_url)

    Result.success(user)
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  private

  def verify_google_token(id_token)
    require 'jwt'
    require 'net/http'

    # Get Google's public keys
    uri = URI('https://www.googleapis.com/oauth2/v1/certs')
    response = Net::HTTP.get_response(uri)
    keys = JSON.parse(response.body)

    # Decode and verify token
    begin
      JWT.decode(
        id_token,
        nil,
        true,
        { algorithms: %w[RS256], jwks: { keys: keys.map { |_, v| v } } }
      )
      JWT.decode(id_token, nil, false)[0]
    rescue JWT::DecodeError => e
      Rails.logger.error("Google token verification failed: #{e}")
      nil
    end
  rescue StandardError => e
    Rails.logger.error("Error verifying Google token: #{e}")
    nil
  end

  def create_user_from_google(google_uid, email, full_name, _picture_url)
    # Generate a random password since Google OAuth users won't use it
    random_password = SecureRandom.hex(16)

    User.create!(
      google_uid:,
      email:,
      full_name:,
      display_name: full_name.split.first,
      password: random_password,
      password_confirmation: random_password,
      otp_verified: true,
      is_active: true,
      provider: 'google'
    )
  end
end
