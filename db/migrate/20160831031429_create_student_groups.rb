class CreateStudentGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :student_groups do |t|
      t.boolean :confirmed
      t.boolean :finalised

      t.timestamps
    end
  end
end
