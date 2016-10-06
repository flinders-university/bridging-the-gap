class CreateRsvps < ActiveRecord::Migration[5.0]
  def change
    create_table :rsvps do |t|
      t.string :full_name
      t.string :email
      t.date :preferred_date

      t.timestamps
    end
  end
end
