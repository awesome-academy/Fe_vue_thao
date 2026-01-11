# frozen_string_literal: true

class ClassService
  def create(params)
    class_obj = SchoolClass.new(params)

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

  def all_classes
    classes = SchoolClass.all
    Result.success(classes)
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  def subjects_of_classes
    subjects = SchoolClass.distinct.pluck(:subject)
    Result.success(subjects)
  rescue StandardError => e
    Result.failure({ error: e.message })
  end
end
