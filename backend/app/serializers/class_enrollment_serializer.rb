# frozen_string_literal: true

class ClassEnrollmentSerializer
  def initialize(enrollment)
    @enrollment = enrollment
  end

  def serialize
    {
      id: @enrollment.id,
      class_id: @enrollment.class_id,
      class_name: @enrollment.class.name,
      student_id: @enrollment.student_id,
      student_name: @enrollment.student.full_name,
      join_date: @enrollment.join_date,
      status: @enrollment.status,
      remaining_sessions: @enrollment.remaining_sessions,
      created_at: @enrollment.created_at,
      updated_at: @enrollment.updated_at
    }
  end

  def self.serialize(enrollment)
    new(enrollment).serialize
  end
end
