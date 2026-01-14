# frozen_string_literal: true

class LeaveRequestService
  def initialize(student_id, class_id)
    @student_id = student_id
    @class_id = class_id
    @student = Student.find(student_id)
    @school_class = SchoolClass.find(class_id)
  end

  def create(params)
    result = validate_enrollment

    return result if result.failure?

    leave_request = LeaveRequest.new(params)
    leave_request.student_id = @student_id
    leave_request.class_id = @class_id

    if leave_request.save
      Result.success(leave_request)
    else
      Result.failure(leave_request.errors.full_messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def update(leave_request, params)
    if leave_request.update(params)
      Result.success(leave_request)
    else
      Result.failure(leave_request.errors.full_messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def by_class(class_id)
    leave_requests = LeaveRequest.for_class(class_id).order(created_at: :desc)
    Result.success(leave_requests)
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def by_id(leave_request_id)
    leave_request = LeaveRequest.find_by(id: leave_request_id)
    if leave_request
      Result.success(leave_request)
    else
      Result.failure(['Leave request not found'])
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def by_student(student_id)
    leave_requests = LeaveRequest.for_student(student_id).order(created_at: :desc)
    Result.success(leave_requests)
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def destroy(leave_request)
    if leave_request.destroy
      Result.success({ message: 'Leave request deleted successfully' })
    else
      Result.failure(leave_request.errors.full_messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def approve(leave_request)
    if leave_request.approve
      Result.success(leave_request)
    else
      Result.failure(leave_request.errors.full_messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def reject(leave_request)
    if leave_request.reject
      Result.success(leave_request)
    else
      Result.failure(leave_request.errors.full_messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  private

  def validate_enrollment
    enrollment = @student.enrollments.find_by(class_id: @class_id, status: 'active')

    return Result.failure(['Student is not enrolled in this class']) unless enrollment

    Result.success(enrollment)
  end
end
