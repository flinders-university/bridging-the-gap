class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.date :when
      t.boolean :visible
      t.boolean :completed

      t.timestamps
    end
  end
end
