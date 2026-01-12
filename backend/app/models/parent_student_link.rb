# frozen_string_literal: true

class ParentStudentLink < ApplicationRecord
  self.table_name = 'parent_student_links'

  # Associations
  belongs_to :parent, class_name: 'User',
                      primary_key: 'user_id'
  belongs_to :student, class_name: 'User',
                       primary_key: 'user_id'

  # Validations
  validate :parent_must_be_parent
  validate :student_must_be_student
  validate :cannot_link_self

  private

  def parent_must_be_parent
    return if parent&.role == 'parent'

    errors.add(:parent_id, 'must be a parent user')
  end

  def student_must_be_student
    return if student&.role == 'student'

    errors.add(:student_id, 'must be a student user')
  end

  def cannot_link_self
    return unless parent_id == student_id

    errors.add(:base, 'cannot link a user to themselves')
  end
end
