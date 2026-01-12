class CreatePackagesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :packages do |t|
      t.string :name, null: false, limit: 100
      t.decimal :price, precision: 15, scale: 2, null: false
      t.integer :duration_days, null: false
      t.json :features
      t.boolean :is_active, default: true

      t.timestamps
    end

    add_index :packages, :name
    add_index :packages, :is_active
  end
end
