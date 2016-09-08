class CreateFgBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :fg_bookings do |t|
      t.integer :user_id
      t.string :booking

      t.timestamps
    end
  end
end
