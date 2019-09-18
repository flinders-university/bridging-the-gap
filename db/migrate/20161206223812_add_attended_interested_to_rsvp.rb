class AddAttendedInterestedToRsvp < ActiveRecord::Migration[5.0]
  def change
    add_column :rsvps, :attended, :boolean
    add_column :rsvps, :interested, :boolean
  end
end
