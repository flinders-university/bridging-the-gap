class CreateMeetings < ActiveRecord::Migration[5.0]
  def change
    create_table :meetings do |t|
      t.string :name
      t.date :date
      t.text :description
      t.boolean :final

      t.timestamps
    end
  end
end
