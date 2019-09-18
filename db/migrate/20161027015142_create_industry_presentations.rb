class CreateIndustryPresentations < ActiveRecord::Migration[5.0]
  def change
    create_table :industry_presentations do |t|
      t.integer :user_id
      t.integer :industry_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
