class CreateStudentBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :student_blogs do |t|
      t.integer :user_id
      t.string :title
      t.string :slug
      t.text :body
      t.boolean :finished

      t.timestamps
    end
  end
end
