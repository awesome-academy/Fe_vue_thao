# frozen_string_literal: true

class ClassService
  def create(params)
    class_obj = Class.new(params)

    if class_obj.save
      Result.success(class_obj)
    else
      Result.failure(class_obj.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def update(class_obj, params)
    if class_obj.update(params)
      Result.success(class_obj)
    else
      Result.failure(class_obj.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def delete(class_obj)
    if class_obj.destroy
      Result.success({ message: 'Class deleted successfully' })
    else
      Result.failure(class_obj.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end
end
