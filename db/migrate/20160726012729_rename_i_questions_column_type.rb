class RenameIQuestionsColumnType < ActiveRecord::Migration[5.0]
  def change
    rename_column :i_questions, :type, :input_type
  end
end
