class AddAttachmentMinutesToMeetings < ActiveRecord::Migration
  def self.up
    change_table :meetings do |t|
      t.attachment :minutes
    end
  end

  def self.down
    remove_attachment :meetings, :minutes
  end
end
