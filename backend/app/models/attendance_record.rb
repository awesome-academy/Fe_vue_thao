# frozen_string_literal: true

class AttendanceRecord < ApplicationRecord
  self.table_name = 'attendance_records'

  # Associations
  belongs_to :attendance_session
  belongs_to :student

  # Validations
  validates :status,
            inclusion: { in: %w[present absent_w_reason absent_no_reason late] }
  validates :score_in_class,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true

  # Enums
  enum status: { present: 'present', absent_w_reason: 'absent_w_reason',
                 absent_no_reason: 'absent_no_reason', late: 'late' }

  # Scopes
  scope :present, -> { where(status: 'present') }
  scope :absent, -> { where(status: %w[absent_w_reason absent_no_reason]) }
  scope :late, -> { where(status: 'late') }
  scope :by_student, ->(student_id) { where(student_id:) }

  # Methods
  def present?
    status == 'present'
  end

  def absent?
    status.in?(%w[absent_w_reason absent_no_reason])
  end
end
