class CreateAttendanceSessionsAndRecordsTable < ActiveRecord::Migration[7.0]
  def change
    # Create Attendance_Sessions table
    create_table :attendance_sessions do |t|
      t.references :class, null: false, foreign_key: true
      t.datetime :date, null: false
      t.text :teacher_note

      t.timestamps
    end

    add_index :attendance_sessions, [:class_id, :date], unique: true

    # Create Attendance_Records table
    create_table :attendance_records do |t|
      t.references :attendance_session, null: false, foreign_key: { to_table: :attendance_sessions }
      t.references :student, null: false, foreign_key: { to_table: :students }
      t.string :status, null: false  # present, absent_w_reason, absent_no_reason, late
      t.string :note, limit: 255
      t.decimal :score_in_class, precision: 4, scale: 2

      t.timestamps
    end

    add_index :attendance_records, [:attendance_session_id, :student_id], unique: true
    add_index :attendance_records, :status

    # Drop old attendances table if exists
    drop_table :attendances if table_exists?(:attendances)
  end
end
