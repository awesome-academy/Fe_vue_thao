# frozen_string_literal: true

class StudentService
  def create(params)
    student = Student.new(params)

    if student.save
      Result.success(student)
    else
      Result.failure(student.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def update(student, params)
    if student.update(params)
      Result.success(student)
    else
      Result.failure(student.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def delete(student)
    if student.destroy
      Result.success({ message: 'Student deleted successfully' })
    else
      Result.failure(student.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end
end
