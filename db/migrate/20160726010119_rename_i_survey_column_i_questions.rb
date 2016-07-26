class RenameISurveyColumnIQuestions < ActiveRecord::Migration[5.0]
  def change
    rename_column :i_questions, :survey_id, :i_survey_id
  end
end
