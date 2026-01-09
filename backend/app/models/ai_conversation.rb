# frozen_string_literal: true

class AiConversation < ApplicationRecord
  self.table_name = 'ai_conversations'

  # Associations
  belongs_to :teacher, class_name: 'Teacher',
                       primary_key: 'user_id'
  belongs_to :context_class, class_name: 'SchoolClass', optional: true
  has_many :ai_messages, dependent: :destroy

  # Validations

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :by_teacher, ->(teacher_id) { where(teacher_id:) }
  scope :with_context, -> { where.not(context_class_id: nil) }

  # Methods
  def add_message(role, content)
    ai_messages.create(role:, content:)
  end

  def conversation_context
    ai_messages.order(:created_at).map do |msg|
      { role: msg.role, content: msg.content }
    end
  end

  def last_message
    ai_messages.order(:created_at).last
  end
end
