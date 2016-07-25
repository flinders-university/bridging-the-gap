class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.boolean :public
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end
