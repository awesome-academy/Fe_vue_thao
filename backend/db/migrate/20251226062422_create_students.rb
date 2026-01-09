class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :full_name, null: false
      t.date :dob
      t.string :parent_name
      t.string :parent_phone
      t.string :school
      t.text :note

      t.timestamps
    end
  end
end
