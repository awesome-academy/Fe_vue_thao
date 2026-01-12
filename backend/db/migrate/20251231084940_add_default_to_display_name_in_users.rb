class AddDefaultToDisplayNameInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :display_name, from: nil, to: "User"
  end
end
