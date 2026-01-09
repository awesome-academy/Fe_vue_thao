# frozen_string_literal: true

class SchoolClass < ApplicationRecord
  self.table_name = 'classes'

  # Associations
  belongs_to :teacher, class_name: 'Teacher',
                       primary_key: 'user_id'
  has_many :enrollments, foreign_key: 'class_id', dependent: :destroy, inverse_of: :school_class
  has_many :students, through: :enrollments, source: :student
  has_many :attendance_sessions, foreign_key: 'class_id', dependent: :destroy, inverse_of: :school_class
  has_many :attendance_records, through: :attendance_sessions
  has_many :assignments, foreign_key: 'class_id', dependent: :destroy, inverse_of: :school_class
  has_many :transactions, foreign_key: 'class_id', dependent: :destroy,
                          optional: true, inverse_of: :school_class
  has_many :ai_conversations, foreign_key: 'context_class_id',
                              dependent: :destroy, optional: true, inverse_of: :school_class

  # Validations
  validates :name, presence: true, length: { minimum: 3, maximum: 150 }
  validates :subject, presence: true, length: { minimum: 2, maximum: 50 }
  validates :fee_per_session, numericality: { greater_than_or_equal_to: 0 },
                              allow_nil: true
  validates :status, inclusion: { in: %w[active completed paused] }

  # Enums
  enum status: { active: 'active', completed: 'completed', paused: 'paused' }

  # Scopes
  scope :active_classes, -> { where(status: 'active') }
  scope :by_subject, ->(subject) { where(subject:) }
  scope :taught_by, ->(teacher_id) { where(teacher_id:) }
  scope :recently_created, -> { order(created_at: :desc) }

  # Methods
  def student_count
    enrollments.where(status: 'active').count
  end

  def total_revenue
    enrollments.where(status: 'active').sum(:tuition_debt)
  end

  def upcoming_sessions
    attendance_sessions.where('date > ?', Time.current).order(:date)
  end
end
