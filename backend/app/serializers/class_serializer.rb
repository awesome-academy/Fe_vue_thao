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
      tuition_fee_per_session: @class.tuition_fee_per_session,
      teacher: teacher_info,
      schedule: @class.schedule,
      student_count: @class.students.count,
      created_at: @class.created_at,
      updated_at: @class.updated_at
    }
  end

  def self.serialize(class_obj)
    new(class_obj).serialize
  end

  private

  def teacher_info
    {
      id: @class.teacher.id,
      full_name: @class.teacher.full_name,
      email: @class.teacher.email
    }
  end
end
