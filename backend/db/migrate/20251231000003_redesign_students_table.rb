class RedesignStudentsTable < ActiveRecord::Migration[7.0]
  def change
    # Add columns to students table to match new schema
    add_column :students, :user_id, :string, unique: true unless column_exists?(:students, :user_id)
    add_column :students, :student_code, :string, unique: true unless column_exists?(:students, :student_code)
    add_column :students, :wallet_balance, :decimal, precision: 15, scale: 2, default: 0 unless column_exists?(:students, :wallet_balance)

    # Add foreign key for user_id
    add_foreign_key :students, :users, column: :user_id, primary_key: :user_id unless foreign_key_exists?(:students, :users)
    
    add_index :students, :user_id, unique: true
    add_index :students, :student_code, unique: true
  end
end
