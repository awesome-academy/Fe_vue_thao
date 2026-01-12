class AddPackageForeignKeyToTeachersTable < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :teachers, :packages, column: :package_id, if_not_exists: true
  end
end
