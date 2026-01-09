class AddOtpFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :otp_code, :string
    add_column :users, :otp_expires_at, :datetime
    add_column :users, :otp_verified, :boolean, default: false
    add_column :users, :admin_approved, :boolean, default: false
    add_column :users, :is_active, :boolean, default: false
    
    add_index :users, :otp_code
  end
end
