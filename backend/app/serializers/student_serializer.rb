# frozen_string_literal: true

class StudentSerializer
  def initialize(student)
    @student = student
  end

  def serialize
    {
      id: @student.id,
      full_name: @student.full_name,
      dob: @student.dob,
      parent_name: @student.parent_name,
      parent_phone: @student.parent_phone,
      school: @student.school,
      note: @student.note,
      class_count: @student.classes.count,
      created_at: @student.created_at,
      updated_at: @student.updated_at
    }
  end

  def self.serialize(student)
    new(student).serialize
  end
end
