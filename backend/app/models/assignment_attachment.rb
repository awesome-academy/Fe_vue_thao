# frozen_string_literal: true

class AssignmentAttachment < ApplicationRecord
  # Associations
  belongs_to :assignment

  # Validations
  validates :file_url, presence: true
  validates :file_name, length: { maximum: 255 }, allow_blank: true

  # Scopes
  scope :by_assignment, lambda { |assignment_id|
                          where(assignment_id:)
                        }
end
