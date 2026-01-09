class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :student, foreign_key: true, null: false
      t.references :class, foreign_key: true, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.date :payment_date, null: false
      t.string :payment_method  # Cash, Transfer, Card
      t.string :status, default: 'Completed'  # Completed, Pending, Failed
      t.text :note

      t.timestamps
    end

    add_index :transactions, :payment_date
    add_index :transactions, [:student_id, :class_id]
  end
end
