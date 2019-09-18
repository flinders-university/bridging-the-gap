class AddAttachmentUnitOverviewToUnitPresentations < ActiveRecord::Migration
  def self.up
    change_table :unit_presentations do |t|
      t.attachment :unit_overview
    end
  end

  def self.down
    remove_attachment :unit_presentations, :unit_overview
  end
end
