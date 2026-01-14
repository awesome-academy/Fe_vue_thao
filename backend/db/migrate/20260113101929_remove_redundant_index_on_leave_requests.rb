class RemoveRedundantIndexOnLeaveRequests < ActiveRecord::Migration[7.0]
  def change
    remove_index :leave_requests,
                 name: "index_leave_requests_on_student_and_date"
  end
end
