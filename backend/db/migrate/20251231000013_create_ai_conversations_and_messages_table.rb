class CreateAiConversationsAndMessagesTable < ActiveRecord::Migration[7.0]
  def change
    # Create AI_Conversations table
    create_table :ai_conversations do |t|
      t.string :teacher_id, null: false
      t.bigint :context_class_id

      t.timestamps
    end

    add_foreign_key :ai_conversations, :teachers, column: :teacher_id, primary_key: :user_id
    add_foreign_key :ai_conversations, :classes, column: :context_class_id
    add_index :ai_conversations, :teacher_id
    add_index :ai_conversations, :context_class_id

    # Create AI_Messages table
    create_table :ai_messages do |t|
      t.references :ai_conversation, null: false, foreign_key: true
      t.string :role, null: false  # user, model
      t.text :content, null: false

      t.timestamps
    end

    add_index :ai_messages, :role
  end
end
