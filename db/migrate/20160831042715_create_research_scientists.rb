class CreateResearchScientists < ActiveRecord::Migration[5.0]
  def change
    create_table :research_scientists do |t|
      t.integer :student_group_id
      t.integer :user_id
      t.string :public_email
      t.string :public_phone
      t.text :public_bio
      t.boolean :enabled

      t.timestamps
    end
  end
end
