# frozen_string_literal: true

class EnrollmentSerializer < ActiveModel::Serializer
  attributes :enrollment_id, :class_id, :student_id, :joined_at, :status,
             :tuition_debt, :sessions_attended, :created_at, :updated_at

  belongs_to :class
  belongs_to :student
end
