class CreateLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :leave_requests do |t|
      t.references :student, null: false, foreign_key: true
      t.date :date, null: false
      t.string :reason
      t.string :status, default: 'pending', null: false
      t.text :teacher_note
      t.datetime :approved_at
      t.string :approved_by

      t.timestamps

      t.index [:student_id, :date], name: 'index_leave_requests_on_student_and_date'
      t.index [:status], name: 'index_leave_requests_on_status'
    end
  end
end
