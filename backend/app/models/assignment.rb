# frozen_string_literal: true

class Assignment < ApplicationRecord
  # Associations
  belongs_to :class, class_name: 'SchoolClass'
  has_many :assignment_attachments, dependent: :destroy
  has_many :submissions, dependent: :destroy

  # Validations
  validates :title, presence: true
  validates :title, length: { minimum: 3, maximum: 200 }
  validates :type, inclusion: { in: %w[homework test project] }, allow_nil: true

  # Enums
  enum assignment_type: { homework: 'homework', test: 'test', project: 'project' }, _suffix: true

  # Scopes
  scope :by_class, ->(class_id) { where(class_id: class_id) }
  scope :upcoming, -> { where('due_date > ?', Time.current).order(due_date: :asc) }
  scope :overdue, -> { where('due_date < ?', Time.current) }
  scope :recent, -> { order(created_at: :desc) }

  # Methods
  def overdue?
    due_date.present? && due_date < Time.current
  end

  delegate :count, to: :submissions, prefix: true

  def graded_submissions_count
    submissions.where(status: 'graded').count
  end
end
