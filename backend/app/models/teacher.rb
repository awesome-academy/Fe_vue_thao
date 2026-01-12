# frozen_string_literal: true

class Teacher < ApplicationRecord
  self.table_name = 'teachers'
  self.primary_key = 'user_id'

  # Associations
  belongs_to :user, primary_key: 'user_id'
  belongs_to :package, optional: true
  has_many :classes, dependent: :destroy
  has_many :ai_conversations, dependent: :destroy

  # Validations
  validates :user_id, uniqueness: true

  # Scopes
  scope :with_active_package, -> { where('package_expiry > ?', Time.current) }
  scope :by_rating, -> { order(rating_avg: :desc) }

  # Methods
  def active_package?
    package_expiry.present? && package_expiry > Time.current
  end

  def update_rating(new_rating)
    update(rating_avg: new_rating)
  end
end
