class CreateClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :classes do |t|
      t.string :name, null: false
      t.string :subject, null: false
      t.string :grade_level
      t.decimal :tuition_fee_per_session, precision: 10, scale: 2
      t.references :teacher, foreign_key: { to_table: :users }, null: false
      t.json :schedule  # Example: { "day_of_week": ["Monday", "Wednesday"] }

      t.timestamps
    end

    add_index :classes, :name
  end
end
