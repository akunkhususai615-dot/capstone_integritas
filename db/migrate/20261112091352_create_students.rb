
class CreateStudents < ActiveRecord::Migration[8.1]
  def change
    create_table :students do |t|
      t.string :nim, null: false
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps
    end

    add_index :students, :nim, unique: true
    add_index :students, :email, unique: true
  end
end
