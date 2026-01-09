# frozen_string_literal: true

class AttendanceSession < ApplicationRecord
  self.table_name = 'attendance_sessions'

  # Associations
  belongs_to :class, class_name: 'SchoolClass'
  has_many :attendance_records,
           dependent: :destroy
  has_many :students, through: :attendance_records

  # Validations
  validates :date, presence: true

  # Scopes
  scope :by_date, -> { order(date: :asc) }
  scope :recent, -> { where('date >= ?', 30.days.ago).order(date: :desc) }
  scope :upcoming, -> { where('date > ?', Time.current).order(date: :asc) }

  # Methods
  def mark_attendance(student_id, status, note = nil)
    record = attendance_records.find_or_create_by(student_id:)
    record.update(status:, note:)
  end

  def attendance_summary
    {
      present: attendance_records.where(status: 'present').count,
      absent_with_reason: attendance_records.where(status: 'absent_w_reason').count,
      absent_no_reason: attendance_records.where(status: 'absent_no_reason').count,
      late: attendance_records.where(status: 'late').count
    }
  end
end
