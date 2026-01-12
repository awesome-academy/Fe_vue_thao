class CreateClassEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :class_enrollments do |t|
      t.references :class, foreign_key: true, null: false
      t.references :student, foreign_key: true, null: false
      t.date :join_date, null: false
      t.string :status, default: 'Active'  # Active, Inactive, Suspended
      t.integer :remaining_sessions, default: 0

      t.timestamps
    end

    add_index :class_enrollments, [:class_id, :student_id], unique: true
  end
end
