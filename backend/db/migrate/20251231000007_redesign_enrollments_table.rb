class RedesignEnrollmentsTable < ActiveRecord::Migration[7.0]
  def change
    # Rename class_enrollments to enrollments and add new columns
    rename_table :class_enrollments, :enrollments

    add_column :enrollments, :tuition_debt, :decimal, precision: 15, scale: 2, default: 0 unless column_exists?(:enrollments, :tuition_debt)
    add_column :enrollments, :sessions_attended, :integer, default: 0 unless column_exists?(:enrollments, :sessions_attended)

    # Rename join_date to joined_at
    if column_exists?(:enrollments, :join_date) && !column_exists?(:enrollments, :joined_at)
      add_column :enrollments, :joined_at, :timestamp
      execute "UPDATE enrollments SET joined_at = join_date"
      remove_column :enrollments, :join_date
    elsif !column_exists?(:enrollments, :joined_at)
      add_column :enrollments, :joined_at, :timestamp, default: -> { 'CURRENT_TIMESTAMP' }
    end

    # Remove remaining_sessions column
    remove_column :enrollments, :remaining_sessions if column_exists?(:enrollments, :remaining_sessions)

    # Ensure status has correct values
    change_column_default :enrollments, :status, 'active'
  end
end
