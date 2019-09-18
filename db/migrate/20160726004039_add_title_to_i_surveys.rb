class AddTitleToISurveys < ActiveRecord::Migration[5.0]
  def change
    add_column :i_surveys, :title, :string
  end
end
