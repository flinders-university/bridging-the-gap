class CreateIQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :i_questions do |t|
      t.integer :survey_id
      t.integer :type
      t.string :description
      t.integer :grouping_value
      t.boolean :enabled
      t.string :comment

      t.timestamps
    end
  end
end
