# frozen_string_literal: true

class AttendanceSessionSerializer < ActiveModel::Serializer
  attributes :session_id, :class_id, :date, :teacher_note, :created_at,
             :updated_at

  belongs_to :class
  has_many :attendance_records
end
