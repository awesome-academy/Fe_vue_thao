# frozen_string_literal: true

class ClassEnrollment < ApplicationRecord
  # Associations
  belongs_to :class
  belongs_to :student

  # Validations
  validates :join_date, presence: true
  validates :status, inclusion: { in: %w[Active Inactive Suspended] }
  validates :remaining_sessions, numericality: { greater_than_or_equal_to: 0 }
  validate :unique_enrollment

  # Enums
  enum status: { Active: 'Active', Inactive: 'Inactive',
                 Suspended: 'Suspended' }

  private

  def unique_enrollment
    if ClassEnrollment.where(class_id:,
                             student_id:).where.not(id:).exists?
      errors.add(:base, 'Student is already enrolled in this class')
    end
  end
end
