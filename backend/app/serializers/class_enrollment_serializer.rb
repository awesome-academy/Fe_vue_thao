# frozen_string_literal: true

class ClassEnrollmentSerializer
  def initialize(enrollment)
    @enrollment = enrollment
  end

  def serialize
    {
      id: @enrollment.id,
      class_id: @enrollment.class_id,
      class_name: @enrollment.school_class&.name,
      teacher_name: @enrollment.school_class&.teacher&.user&.full_name,
      schedule: @enrollment.school_class&.schedule,
      student_id: @enrollment.student_id,
      student_name: @enrollment.student&.full_name,
      joined_at: @enrollment.joined_at,
      status: @enrollment.status,
      tuition_debt: @enrollment.tuition_debt,
      sessions_attended: @enrollment.sessions_attended,
      created_at: @enrollment.created_at,
      updated_at: @enrollment.updated_at
    }
  end

  def self.serialize(enrollment)
    new(enrollment).serialize
  end
end
