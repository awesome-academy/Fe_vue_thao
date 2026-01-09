class RedesignTransactionsTable < ActiveRecord::Migration[7.0]
  def change
    # Redesign transactions table to new schema
    rename_column :transactions, :student_id, :user_id if column_exists?(:transactions, :student_id)
    
    add_column :transactions, :type, :string unless column_exists?(:transactions, :type)
    add_column :transactions, :method, :string unless column_exists?(:transactions, :method)
    
    # Change payment_date to created_at if needed
    if column_exists?(:transactions, :payment_date) && !column_exists?(:transactions, :created_at)
      add_column :transactions, :created_at, :timestamp
      execute "UPDATE transactions SET created_at = payment_date"
      remove_column :transactions, :payment_date
    end

    # Rename payment_method to method if exists
    if column_exists?(:transactions, :payment_method)
      add_column :transactions, :method, :string unless column_exists?(:transactions, :method)
      execute "UPDATE transactions SET method = payment_method"
      remove_column :transactions, :payment_method
    end

    # Rename note to description
    if column_exists?(:transactions, :note)
      add_column :transactions, :description, :string unless column_exists?(:transactions, :description)
      execute "UPDATE transactions SET description = note"
      remove_column :transactions, :note
    end

    # Remove foreign key to students and add to users
    if foreign_key_exists?(:transactions, :students)
      remove_foreign_key :transactions, :students
    end
    
    add_foreign_key :transactions, :users, column: :user_id unless foreign_key_exists?(:transactions, :users)

    # Update indexes - only add if they don't exist
    add_index :transactions, :user_id unless index_exists?(:transactions, :user_id)
    add_index :transactions, :created_at unless index_exists?(:transactions, :created_at)
  end
end
