class RedesignUsersTable < ActiveRecord::Migration[7.0]
  def change
    # Modify existing users table to match new schema
    # Add new columns
    add_column :users, :user_id, :string, unique: true unless column_exists?(:users, :user_id)
    add_column :users, :display_name, :string, limit: 100 unless column_exists?(:users, :display_name)
    add_column :users, :photo_url, :text unless column_exists?(:users, :photo_url)
    add_column :users, :phone_number, :string, limit: 20 unless column_exists?(:users, :phone_number)
    
    # Migrate role from enum to ENUM
    # Change full_name to display_name if not already done
    remove_index :users, :email if index_exists?(:users, :email)
    add_index :users, :email, unique: true
    add_index :users, :user_id, unique: true
  end
end
