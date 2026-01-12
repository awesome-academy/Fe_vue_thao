# frozen_string_literal: true

class Package < ApplicationRecord
  # Associations
  has_many :teachers, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true,
                   length: { minimum: 3, maximum: 100 }
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0 }
  validates :duration_days, presence: true,
                            numericality: { only_integer: true, greater_than: 0 }

  # Scopes
  scope :active, -> { where(is_active: true) }
  scope :sorted_by_price, -> { order(price: :asc) }

  # Methods
  def expiry_date_for(purchase_date = Time.current)
    purchase_date + duration_days.days
  end

  def to_s
    "#{name} (#{duration_days} days - #{price})"
  end
end
