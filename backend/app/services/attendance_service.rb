# frozen_string_literal: true

class AttendanceService
  def record(class_id, student_id, params)
    attendance = Attendance.new(class_id:, student_id:,
                                **params)

    if attendance.save
      Result.success(attendance)
    else
      Result.failure(attendance.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def update(attendance, params)
    if attendance.update(params)
      Result.success(attendance)
    else
      Result.failure(attendance.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def delete(attendance)
    if attendance.destroy
      Result.success({ message: 'Attendance record deleted successfully' })
    else
      Result.failure(attendance.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def get_class_attendance(class_id, date)
    attendances = Attendance.by_class(class_id).by_date(date)
    Result.success(attendances)
  rescue StandardError => e
    Result.failure({ error: e.message })
  end
end
