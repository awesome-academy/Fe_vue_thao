# frozen_string_literal: true

class Transaction < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :class, class_name: 'SchoolClass',
                     optional: true

  # Validations
  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :type, inclusion: { in: %w[tuition_fee package_subscription] }
  validates :method, inclusion: { in: %w[cash transfer online_gateway] }
  validates :status, inclusion: { in: %w[pending completed failed] }

  # Enums
  enum transaction_type: { tuition_fee: 'tuition_fee', package_subscription: 'package_subscription' },
       _suffix: true
  enum transaction_method: { cash: 'cash', transfer: 'transfer', online_gateway: 'online_gateway' },
       _suffix: true
  enum status: { pending: 'pending', completed: 'completed', failed: 'failed' }

  # Scopes
  scope :completed, -> { where(status: 'completed') }
  scope :pending, -> { where(status: 'pending') }
  scope :tuition_payments, -> { where(type: 'tuition_fee') }
  scope :package_payments, -> { where(type: 'package_subscription') }
  scope :by_user, ->(user_id) { where(user_id:) }
  scope :by_class, ->(class_id) { where(class_id:) }
  scope :recent, -> { order(created_at: :desc) }
  scope :between_dates, lambda { |start_date, end_date|
                          where(created_at: start_date..end_date)
                        }

  # Methods
  def mark_as_completed
    update(status: 'completed')
  end

  def mark_as_failed
    update(status: 'failed')
  end

  def pending?
    status == 'pending'
  end

  def completed?
    status == 'completed'
  end
end
