# frozen_string_literal: true

require 'jwt'

module Api
  module V1
    class AuthenticationsController < Api::V1::BaseController
      # Skip authentication for these actions
      skip_before_action :authenticate_request!,
                         only: %i[sign_up verify_otp resend_otp login
                                  forget_password google_login]
      # api/v1/auth/sign-up
      def sign_up
        result = UserService.new.create(user_params)
        if result.success?
          render_success result.data, :created
        else
          render_error result.errors, :unprocessable_entity
        end
      end

      # api/v1/auth/verify-otp
      def verify_otp
        user = User.find_by(email: verify_otp_params[:email])
        result = OtpService.new.verify_otp(user,
                                           verify_otp_params[:otp_code])
        if result.success?
          render_success UserSerializer.serialize(user), :ok
        else
          render_error result.errors, :unprocessable_entity
        end
      end

      # api/v1/auth/resend-otp
      def resend_otp
        result = OtpService.new.resend_otp(resend_otp_params[:email])
        if result.success?
          render_success result.data, :ok
        else
          render_error result.errors, :unprocessable_entity
        end
      end

      # api/v1/auth/login
      def login
        result = UserService.new.authenticate(login_params[:email],
                                              login_params[:password])
        if result.success?
          user = result.data
          token = encode_token({ user_id: user.id })
          render_success({ user: UserSerializer.serialize(user), token: }, :ok)

        else
          render_error result.errors, :unauthorized
        end
      end

      #  api/v1/auth/forget-password
      def forget_password
        result = UserService.new.forget_password(forget_password_params[:email])
        if result.success?
          render_success result.data, :ok
        else
          render_error result.errors, :unprocessable_entity
        end
      end

      # POST /api/v1/auth/google-login
      def google_login
        result = OAuthService.new.authenticate_google(google_login_params[:id_token])
        if result.success?
          user = result.data
          token = encode_token({ user_id: user.id })
          render_success({ user: UserSerializer.serialize(user), token: }, :ok)
        else
          render_error result.errors, :unauthorized
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :full_name, :password, :role)
      end

      def verify_otp_params
        params.require(:otp).permit(:email, :otp_code)
      end

      def resend_otp_params
        params.require(:user).permit(:email)
      end

      def forget_password_params
        params.require(:user).permit(:email)
      end

      def login_params
        params.require(:user).permit(:email, :password)
      end

      def google_login_params
        params.require(:user).permit(:id_token)
      end

      def encode_token(payload)
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
      end
    end
  end
end
