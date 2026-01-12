# frozen_string_literal: true

class AiMessage < ApplicationRecord
  self.table_name = 'ai_messages'

  # Associations
  belongs_to :ai_conversation

  # Validations
  validates :role, :content, presence: true
  validates :role, inclusion: { in: %w[user model] }

  # Enums
  enum role: { user: 'user', model: 'model' }

  # Scopes
  scope :by_conversation, lambda { |conversation_id|
                            where(ai_conversation_id: conversation_id)
                          }
  scope :user_messages, -> { where(role: 'user') }
  scope :model_messages, -> { where(role: 'model') }
  scope :recent, -> { order(created_at: :asc) }
end
