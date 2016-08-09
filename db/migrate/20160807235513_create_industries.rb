class CreateIndustries < ActiveRecord::Migration[5.0]
  def change
    create_table :industries do |t|
      t.integer :user_id
      t.string :name
      t.text :address
      t.string :phone
      t.string :email
      t.string :website
      t.string :stem_foci
      t.text :description
      t.text :blurb
      t.boolean :active

      t.timestamps
    end
  end
end
