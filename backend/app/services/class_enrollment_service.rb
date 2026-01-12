# frozen_string_literal: true

class ClassEnrollmentService
  def enroll(class_id, student_id, params)
    enrollment = ClassEnrollment.new(class_id:,
                                     student_id:, **params)

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

  def unenroll(enrollment)
    if enrollment.destroy
      Result.success({ message: 'Student unenrolled successfully' })
    else
      Result.failure(enrollment.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end
end
