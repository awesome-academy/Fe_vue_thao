class AddUniqueIndexToPackagesName < ActiveRecord::Migration[7.0]
  def change
    add_index :packages, :name, unique: true, if_not_exists: true
  end
end
