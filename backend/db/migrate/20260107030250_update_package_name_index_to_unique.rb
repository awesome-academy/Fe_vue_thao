class UpdatePackageNameIndexToUnique < ActiveRecord::Migration[7.0]
  def change
    remove_index :packages, :name if index_exists?(:packages, :name)
    add_index :packages, :name, unique: true
  end
end
