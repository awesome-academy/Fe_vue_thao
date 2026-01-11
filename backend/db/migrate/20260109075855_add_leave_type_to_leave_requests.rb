class AddLeaveTypeToLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :leave_requests, :leave_type, :string, default: 'temporary', null: false
    add_index :leave_requests, :leave_type
  end
end
