# frozen_string_literal: true

class UserService
  # Get user by ID
  def get_id(id)
    user = User.find(id)
    Result.success(user)
  rescue ActiveRecord::RecordNotFound => e
    Result.failure({ error: e.message })
  end

  # Create a new user and send OTP
  def create(params)
    user = User.new(params) if check_email_exists(params[:email]).data[:exists] == false
    if user.save
      # Send OTP email
      otp_result = OtpService.new.generate_and_send_otp(user)

      if otp_result.success?
        Result.success({
                         message:
                         'User created successfully. OTP sent to email.',
                         user:
                       })
      else
        # If sending email fails, delete user
        user.destroy
        Result.failure(otp_result.error)
      end
    else
      Result.failure(user.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  # Update user
  def update(user, params)
    if user.update(params)
      Result.success(user)
    else
      Result.failure(user.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  # Delete user
  def delete(user)
    if user.destroy
      Result.success({ message: 'User deleted successfully' })
    else
      Result.failure(user.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def authenticate(email, password)
    user = User.find_by(email:)
    return Result.failure({ error: 'Invalid email or password' }) if user.nil?

    # Check if user is active
    return Result.failure({ error: 'User account is not activated yet' }) unless user.is_active?

    return Result.failure({ error: 'Invalid credentials' }) unless user.authenticate(password)

    Result.success(user)
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  # Check if email exists
  def check_email_exists(email)
    user = User.find_by(email:)
    if user.nil?
      Result.success({ exists: false })
    else
      Result.success({ exists: true })
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def forget_password(email)
    user = User.find_by(email:)
    return Result.failure({ error: 'User not found' }) if user.nil?

    new_password = SecureRandom.hex(8)
    user.password = new_password
    return Result.failure(user.errors.messages) unless user.save

    UserMailer.send_password(user, new_password).deliver_later

    Result.success({ message: "Password reset instructions sent to #{email}" })
  rescue StandardError => e
    Result.failure({ error: e.message })
  end
end
