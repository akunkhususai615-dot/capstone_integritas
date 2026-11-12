
class CreateAssignments < ActiveRecord::Migration[8.1]
  def change
    create_table :assignments do |t|
      t.references :course, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.date :deadline, null: false

      t.timestamps
    end

    add_index :assignments, :title
    add_index :assignments, :deadline
  end
end
