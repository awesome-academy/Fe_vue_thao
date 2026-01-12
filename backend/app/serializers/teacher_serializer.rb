# frozen_string_literal: true

class TeacherSerializer < ApplicationRecord::Serializer
  attributes :user_id, :bio, :package_id, :package_expiry, :rating_avg,
             :created_at, :updated_at

  belongs_to :user
  belongs_to :package, optional: true
  has_many :classes
end
