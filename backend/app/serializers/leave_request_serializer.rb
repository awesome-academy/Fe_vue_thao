# frozen_string_literal: true

class LeaveRequestSerializer
  def initialize(leave_request)
    @leave_request = leave_request
  end

  def serialize
    {
      id: @leave_request.id,
      student: student_info,
      class: class_info,
      date: @leave_request.date,
      reason: @leave_request.reason,
      status: @leave_request.status,
      teacher_note: @leave_request.teacher_note,
      leave_type: @leave_request.leave_type,
      created_at: @leave_request.created_at,
      updated_at: @leave_request.updated_at
    }
  end

  def self.serialize(leave_request)
    new(leave_request).serialize
  end
  def self.serialize_collection(leave_requests)
    leave_requests.map { |leave_request| new(leave_request).serialize }
  end

  private

  def student_info
    return nil if @leave_request.student.nil?

    {
      id: @leave_request.student.id,
      full_name: @leave_request.student.full_name,
      email: @leave_request.student.user.email
    }
  end

  def class_info
    return nil if @leave_request.school_class.nil?

    {
      id: @leave_request.school_class.id,
      name: @leave_request.school_class.name,
      subject: @leave_request.school_class.subject
    }
  end
end
