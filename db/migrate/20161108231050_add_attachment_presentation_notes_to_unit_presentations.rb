class AddAttachmentPresentationNotesToUnitPresentations < ActiveRecord::Migration
  def self.up
    change_table :unit_presentations do |t|
      t.attachment :presentation
      t.attachment :notes
    end
  end

  def self.down
    remove_attachment :unit_presentations, :presentation
    remove_attachment :unit_presentations, :notes
  end
end
