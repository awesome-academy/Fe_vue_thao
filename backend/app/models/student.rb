# frozen_string_literal: true

class Student < ApplicationRecord
  self.table_name = 'students'

  # Associations
  belongs_to :user
  has_many :enrollments, dependent: :destroy
  has_many :classes, through: :enrollments
  has_many :attendance_records, dependent: :destroy
  has_many :submissions, dependent: :destroy
  has_many :parent_student_links, dependent: :destroy
  has_many :parents, through: :parent_student_links, source: :parent
  has_many :leave_requests, dependent: :destroy

  # Validations
  validates :user_id, uniqueness: true
  validates :student_code, presence: true, uniqueness: true
  validates :wallet_balance, numericality: { greater_than_or_equal_to: 0 }

  # Scopes
  scope :with_debt, -> { where('tuition_debt > 0') }
  scope :sorted_by_balance, -> { order(wallet_balance: :desc) }

  # Methods
  def full_name
    user&.display_name
  end

  def tuition_payable?(amount)
    if wallet_balance >= amount
      update(wallet_balance: wallet_balance - amount)
      true
    else
      false
    end
  end

  def add_to_wallet(amount)
    update(wallet_balance: wallet_balance + amount)
  end

  def total_debt
    enrollments.sum(:tuition_debt)
  end
end
