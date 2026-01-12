# frozen_string_literal: true

class AttendanceRecordSerializer < ActiveModel::Serializer
  attributes :record_id, :session_id, :student_id, :status, :note,
             :score_in_class, :created_at, :updated_at

  belongs_to :attendance_session
  belongs_to :student
end
