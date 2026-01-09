# frozen_string_literal: true

class Attendance < ApplicationRecord
  # Associations
  belongs_to :class
  belongs_to :student

  # Validations
  validates :attendance_date, presence: true
  validates :status, inclusion: { in: %w[Present Absent Late Excused] }

  # Enums
  enum status: { Present: 'Present', Absent: 'Absent', Late: 'Late',
                 Excused: 'Excused' }

  # Scopes
  scope :by_date, ->(date) { where(attendance_date: date) }
  scope :by_class, ->(class_id) { where(class_id:) }
  scope :by_student, ->(student_id) { where(student_id:) }
end
