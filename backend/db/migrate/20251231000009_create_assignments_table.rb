class CreateAssignmentsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.references :class, null: false, foreign_key: true
      t.string :title, null: false, limit: 200
      t.text :content
      t.datetime :due_date
      t.string :type  # homework, test, project

      t.timestamps
    end

    add_index :assignments, :due_date
  end
end
