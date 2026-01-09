class CreateSubmissionsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :submissions do |t|
      t.references :assignment, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: { to_table: :students }
      t.text :content
      t.text :file_url
      t.datetime :submitted_at, null: false
      t.string :status, default: 'submitted'  # submitted, late, graded, resubmit_requested
      t.decimal :score, precision: 5, scale: 2
      t.text :teacher_feedback

      t.timestamps
    end

    add_index :submissions, [:assignment_id, :student_id], unique: true
    add_index :submissions, :status
  end
end
