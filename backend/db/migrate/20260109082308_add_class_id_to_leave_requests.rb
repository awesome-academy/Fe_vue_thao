class AddClassIdToLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :leave_requests, :class_id, :bigint
    add_index :leave_requests, :class_id
    add_foreign_key :leave_requests, :classes, column: :class_id
  end
end
