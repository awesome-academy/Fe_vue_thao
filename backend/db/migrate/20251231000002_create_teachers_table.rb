class CreateTeachersTable < ActiveRecord::Migration[7.0]
  def change
    create_table :teachers, id: false do |t|
      t.string :user_id, null: false, primary_key: true
      t.text :bio
      t.integer :package_id
      t.datetime :package_expiry
      t.decimal :rating_avg, precision: 3, scale: 2, default: 0.0

      t.timestamps
    end

    add_foreign_key :teachers, :users, column: :user_id, primary_key: :user_id
    add_index :teachers, :package_id
  end
end
