# frozen_string_literal: true

class OtpService
  OTP_VALIDITY_DURATION = 10.minutes
  # Generates a 6-digit OTP, saves it to the user, and sends it via email.
  def generate_and_send_otp(user)
    otp_code = generate_otp_code
    user.update(
      otp_code:,
      otp_expires_at: Time.current + OTP_VALIDITY_DURATION
    )
    UserMailer.send_otp_email(user, otp_code).deliver_later

    Result.success({ message: "OTP sent to #{user.email}" })
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  # Verifies the provided OTP code for the user.
  def verify_otp(user, otp_code)
    return Result.failure({ error: 'OTP has not been sent' }) if user.otp_code.blank?

    return Result.failure({ error: 'OTP has expired' }) if user.otp_expires_at < Time.current

    return Result.failure({ error: 'Invalid OTP' }) if user.otp_code != otp_code

    if user.role == 'student' && user.student_profile.nil?
      student_code = generate_student_code
      Student.create!(
        user_id: user.id,
        full_name: user.full_name,
        student_code: student_code,
        wallet_balance: 0
      )
    end
    user.update(
      otp_verified: true,
      otp_code: nil,
      otp_expires_at: nil
    )

    Result.success({ message: 'Email verified successfully' })
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  # Resend OTP
  def resend_otp(email)
    user = User.find_by(email:)
    return Result.failure({ error: 'User not found' }) if user.nil?

    return Result.failure({ error: 'User email is already verified' }) if user.otp_verified?

    generate_and_send_otp(user)
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  # Checks if the user has fully activated their account.

  def user_fully_activated?(user)
    user.otp_verified?
  end

  private

  # Generates a random 6-digit OTP code.
  def generate_otp_code
    SecureRandom.random_bytes(3).unpack1('H*').upcase[0, 6].rjust(6, '0')
  end

  def generate_student_code
    loop do
      code = "ST#{Time.current.strftime('%Y%m%d')}#{rand(1000..9999)}"
      break code unless Student.exists?(student_code: code)
    end
  end
end
