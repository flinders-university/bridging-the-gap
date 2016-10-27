class AddAttachmentPresentationScriptToIndustryPresentations < ActiveRecord::Migration
  def self.up
    change_table :industry_presentations do |t|
      t.attachment :presentation
      t.attachment :script
    end
  end

  def self.down
    remove_attachment :industry_presentations, :presentation
    remove_attachment :industry_presentations, :script
  end
end
