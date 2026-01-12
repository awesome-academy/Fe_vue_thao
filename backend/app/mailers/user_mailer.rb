# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: ENV['MAIL_FROM'] || 'noreply@thuclass.com'
  # Send OTP email
  def send_otp_email(user, otp_code)
    @user = user
    @otp_code = otp_code
    mail(to: @user.email, subject: I18n.t('mailers.user_mailer.send_otp_email.subject'))
  end

  def send_password(user, new_password)
    @user = user
    @password = new_password
    mail(to: @user.email, subject: I18n.t('mailers.user_mailer.send_password.subject'))
  end
end
