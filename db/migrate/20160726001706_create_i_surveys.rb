class CreateISurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :i_surveys do |t|
      t.string :description
      t.integer :group_id
      t.integer :form_id
      t.string :coding_explanation
      t.boolean :enabled

      t.timestamps
    end
  end
end
