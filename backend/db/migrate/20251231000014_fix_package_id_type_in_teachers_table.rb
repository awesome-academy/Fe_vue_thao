class FixPackageIdTypeInTeachersTable < ActiveRecord::Migration[7.0]
  def change
    change_column :teachers, :package_id, :bigint
  end
end
