# frozen_string_literal: true

class ClassEnrollmentService
  def enroll(class_id, student_id)
    enrollment = Enrollment.new(
      class_id: class_id,
      student_id: student_id,
      status: 'pending'
    )
    if enrollment.save
      Result.success(enrollment)
    else
      Result.failure(enrollment.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def update(enrollment, params)
    if enrollment.update(params)
      Result.success(enrollment)
    else
      Result.failure(enrollment.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def get_enrollments_by_student(student_id)
    enrollments = Enrollment.by_student(student_id).order(created_at: :desc)
    Result.success(enrollments)
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def un_enroll(class_id, student_id)
    enrollment = Enrollment.find_by(class_id: class_id, student_id: student_id)
    if enrollment&.destroy
      Result.success({ message: 'Student unenrolled successfully' })
    else
      Result.failure(enrollment ? enrollment.errors.messages : { error: 'Enrollment not found' })
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end
end
