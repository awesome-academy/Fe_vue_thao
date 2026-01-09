# frozen_string_literal: true

class AssignmentSerializer < ActiveModel::Serializer
  attributes :assignment_id, :class_id, :title, :content, :due_date, :type,
             :created_at, :updated_at

  belongs_to :class
  has_many :assignment_attachments
  has_many :submissions
end
