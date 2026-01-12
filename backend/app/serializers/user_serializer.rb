# frozen_string_literal: true

class UserSerializer
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def serialize
    {
      id: user.id,
      email: user.email,
      full_name: user.full_name,
      role: user.role,
      created_at: user.created_at,
      updated_at: user.updated_at
    }
  end

  def self.serialize(user)
    new(user).serialize
  end
end
