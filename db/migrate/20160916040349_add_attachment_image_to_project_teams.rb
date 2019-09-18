class AddAttachmentImageToProjectTeams < ActiveRecord::Migration
  def self.up
    change_table :project_teams do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :project_teams, :image
  end
end
