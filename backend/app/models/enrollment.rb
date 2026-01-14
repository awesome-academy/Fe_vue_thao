# frozen_string_literal: true

class Enrollment < ApplicationRecord
  self.table_name = 'enrollments'

  # Associations
  belongs_to :school_class, class_name: 'SchoolClass', foreign_key: 'class_id', inverse_of: :enrollments
  belongs_to :student
  has_many :attendance_records, through: :school_class, source: :attendance_records
  has_many :submissions, through: :school_class, source: :submissions

  # Validations
  validates :status, inclusion: { in: %w[active dropped pending] }
  validates :tuition_debt, numericality: { greater_than_or_equal_to: 0 }
  validates :sessions_attended,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :unique_enrollment

  # Enums
  enum status: { active: 'active', dropped: 'dropped', pending: 'pending' }

  # Scopes
  scope :with_debt, -> { where('tuition_debt > 0') }
  scope :by_class, ->(class_id) { where(class_id:) }
  scope :by_student, ->(student_id) { where(student_id:) }
  # Methods
  def pay_debt(amount)
    return false if amount > tuition_debt

    update(tuition_debt: tuition_debt - amount)
  end

  def mark_attended
    update(sessions_attended: sessions_attended + 1)
  end

  def attendance_rate
    return 0 if sessions_attended.zero?

    (sessions_attended.to_f / school_class.attendance_sessions.count * 100).round(2)
  end

  private

  def unique_enrollment
    if Enrollment.where(class_id:,
                        student_id:).where.not(id:).exists?
      errors.add(:base, 'Student is already enrolled in this class')
    end
  end
end
