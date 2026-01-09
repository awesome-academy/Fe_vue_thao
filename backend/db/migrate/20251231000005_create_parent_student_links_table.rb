class CreateParentStudentLinksTable < ActiveRecord::Migration[7.0]
  def change
    create_table :parent_student_links, id: false do |t|
      t.string :parent_id, null: false
      t.string :student_id, null: false

      t.timestamps
    end

    execute "ALTER TABLE parent_student_links ADD PRIMARY KEY (parent_id, student_id)"
    add_foreign_key :parent_student_links, :users, column: :parent_id, primary_key: :user_id
    add_foreign_key :parent_student_links, :users, column: :student_id, primary_key: :user_id
    
    add_index :parent_student_links, :parent_id
    add_index :parent_student_links, :student_id
  end
end
