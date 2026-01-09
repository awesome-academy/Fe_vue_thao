class RedesignClassesTable < ActiveRecord::Migration[7.0]
  def change
    # Add new columns to classes table
    add_column :classes, :description, :text unless column_exists?(:classes, :description)
    add_column :classes, :fee_per_session, :decimal, precision: 15, scale: 2 unless column_exists?(:classes, :fee_per_session)
    add_column :classes, :status, :string, default: 'active' unless column_exists?(:classes, :status)
    add_column :classes, :cover_image, :text unless column_exists?(:classes, :cover_image)

    # Rename tuition_fee_per_session to fee_per_session if exists
    if column_exists?(:classes, :tuition_fee_per_session)
      execute "UPDATE classes SET fee_per_session = tuition_fee_per_session WHERE fee_per_session IS NULL"
      remove_column :classes, :tuition_fee_per_session
    end

    add_index :classes, :status
  end
end
