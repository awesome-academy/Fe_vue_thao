# frozen_string_literal: true

class Parent < ApplicationRecord
  self.table_name = 'users'

  # Associations
  has_many :parent_student_links,
           primary_key: 'user_id', dependent: :destroy
  has_many :students, through: :parent_student_links, source: :student

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :display_name, presence: true, length: { minimum: 2, maximum: 100 }

  # Scopes
  scope :parents, -> { where(role: 'parent') }
end
