# frozen_string_literal: true

class LeaveRequest < ApplicationRecord
  belongs_to :student
  belongs_to :school_class, class_name: 'SchoolClass', foreign_key: :class_id, inverse_of: :leave_requests

  # Enums
  enum leave_type: { temporary: 'temporary', permanent: 'permanent' }

  # Validations
  validates :reason, presence: true
  validates :status, inclusion: { in: %w[pending approved rejected] }
  validates :leave_type, inclusion: { in: %w[temporary permanent] }
  validates :date, presence: true, if: -> { temporary? }
  validates :date, absence: true, if: -> { permanent? }
  validate :permanent_request_unique_per_student, if: -> { permanent? }
  validate :class_id_matches_student_enrollment

  # Scopes
  scope :pending, -> { where(status: 'pending') }
  scope :approved, -> { where(status: 'approved') }
  scope :rejected, -> { where(status: 'rejected') }
  scope :for_student, ->(student_id) { where(student_id: student_id) }
  scope :for_class, ->(class_id) { where(class_id: class_id) }
  scope :on_date, ->(date) { where(date: date) }
  scope :temporary, -> { where(leave_type: 'temporary') }
  scope :permanent, -> { where(leave_type: 'permanent') }

  private

  def permanent_request_unique_per_student
    existing = LeaveRequest.where(student_id: student_id, leave_type: 'permanent')
                           .where(status: %w[pending approved])
                           .where.not(id: id)
    return unless existing.exists?

    errors.add(:leave_type, 'Student already has a pending or approved permanent leave request')
  end

  def class_id_matches_student_enrollment
    return unless student_id.present? && class_id.present?

    has_enrollment = student.enrollments.exists?(class_id: class_id, status: 'active')
    return if has_enrollment

    errors.add(:class_id, 'Student is not enrolled in this class or enrollment is inactive')
  end
end
