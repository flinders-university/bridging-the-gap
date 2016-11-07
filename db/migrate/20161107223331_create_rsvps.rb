class CreateRsvps < ActiveRecord::Migration[5.0]
  def change
    create_table :rsvps do |t|
      t.string :full_name
      t.string :email
      t.string :role
      t.string :school
      t.string :year_level
      t.string :for_full_name
      t.string :for_email
      t.boolean :attending_too

      t.timestamps
    end
  end
end
