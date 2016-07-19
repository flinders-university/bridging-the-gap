class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.integer :level
      t.string :name
      t.string :contact
      t.text :description

      t.timestamps
    end
  end
end
