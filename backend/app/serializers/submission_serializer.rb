# frozen_string_literal: true

class SubmissionSerializer < ActiveModel::Serializer
  attributes :submission_id, :assignment_id, :student_id, :content, :file_url,
             :submitted_at, :status, :score, :teacher_feedback, :created_at, :updated_at

  belongs_to :assignment
  belongs_to :student
end
