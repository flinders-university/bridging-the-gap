class CreateFocusGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :focus_groups do |t|
      t.string :name
      t.integer :user_id
      t.datetime :start
      t.integer :slots

      t.timestamps
    end
  end
end
