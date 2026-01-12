class RemoveAdminApprovedFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :admin_approved, :boolean
  end
end
