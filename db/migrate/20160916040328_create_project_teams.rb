class CreateProjectTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :project_teams do |t|
      t.integer :user_id
      t.string :title
      t.string :slug
      t.text :description
      t.integer :team
      t.boolean :enabled

      t.timestamps
    end
  end
end
