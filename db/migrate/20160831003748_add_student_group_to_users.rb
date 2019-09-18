class AddStudentGroupToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :student_group_id, :integer
  end
end
