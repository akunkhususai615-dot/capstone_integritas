
class CreateSubmissions < ActiveRecord::Migration[8.1]
  def change
    create_table :submissions do |t|
      t.references :student, null: false, foreign_key: true
      t.references :assignment, null: false, foreign_key: true

      t.decimal :score, precision: 5, scale: 2
      t.string :status, null: false, default: "pending"
      t.datetime :submitted_at

      t.timestamps
    end

    add_index :submissions,
              [:student_id, :assignment_id],
              unique: true,
              name: "index_submissions_on_student_and_assignment"

    add_check_constraint :submissions,
      "score IS NULL OR (score >= 0 AND score <= 100)",
      name: "check_submission_score_range"
  end
end
