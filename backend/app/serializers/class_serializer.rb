# frozen_string_literal: true

class ClassSerializer
  def initialize(class_obj)
    @class = class_obj
  end

  def serialize
    {
      id: @class.id,
      name: @class.name,
      subject: @class.subject,
      grade_level: @class.grade_level,
      fee_per_session: @class.fee_per_session,
      teacher: teacher_info,
      schedule: @class.schedule,
      student_count: @class.enrollments.active.count,
      created_at: @class.created_at,
      updated_at: @class.updated_at
    }
  end

  def self.serialize(class_obj)
    new(class_obj).serialize
  end

  def self.serialize_collection(classes)
    classes.map { |class_obj| new(class_obj).serialize }
  end

  private

  def teacher_info
    return nil if @class.teacher.nil?

    {
      id: @class.teacher.id,
      full_name: @class.teacher.user&.full_name,
      email: @class.teacher.user&.email
    }
  end
end
