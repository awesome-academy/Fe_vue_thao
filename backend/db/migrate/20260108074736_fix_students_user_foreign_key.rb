class FixStudentsUserForeignKey < ActiveRecord::Migration[7.0]
  def change
    # Remove old foreign key constraint
    remove_foreign_key :students, :users if foreign_key_exists?(:students, :users)
    
    # Change user_id from string to bigint
    change_column :students, :user_id, :bigint
    
    # Add correct foreign key: students.user_id -> users.id
    add_foreign_key :students, :users, column: :user_id
  end
end
