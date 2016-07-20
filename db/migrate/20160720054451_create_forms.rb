class CreateForms < ActiveRecord::Migration[5.0]
  def change
    create_table :forms do |t|
      t.string :title
      t.integer :group_id
      t.string :description
      t.text :body
      t.date :date_required

      t.timestamps
    end
  end
end
