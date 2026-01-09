class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :class, foreign_key: true, null: false
      t.references :student, foreign_key: true, null: false
      t.date :attendance_date, null: false
      t.string :status, default: 'Present'  # Present, Absent, Late, Excused
      t.text :note

      t.timestamps
    end

    add_index :attendances, [:class_id, :attendance_date]
    add_index :attendances, [:student_id, :attendance_date]
  end
end
