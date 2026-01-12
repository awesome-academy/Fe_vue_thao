class CreateAssignmentAttachmentsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :assignment_attachments do |t|
      t.references :assignment, null: false, foreign_key: true
      t.text :file_url, null: false
      t.string :file_name, limit: 255

      t.timestamps
    end
  end
end
