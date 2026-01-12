# frozen_string_literal: true

class AttendanceSerializer
  def initialize(attendance)
    @attendance = attendance
  end

  def serialize
    {
      id: @attendance.id,
      class_id: @attendance.class_id,
      class_name: @attendance.class.name,
      student_id: @attendance.student_id,
      student_name: @attendance.student.full_name,
      attendance_date: @attendance.attendance_date,
      status: @attendance.status,
      note: @attendance.note,
      created_at: @attendance.created_at,
      updated_at: @attendance.updated_at
    }
  end

  def self.serialize(attendance)
    new(attendance).serialize
  end
end
