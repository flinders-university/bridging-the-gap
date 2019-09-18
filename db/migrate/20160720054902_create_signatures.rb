class CreateSignatures < ActiveRecord::Migration[5.0]
  def change
    create_table :signatures do |t|
      t.integer :user_id
      t.integer :form_id
      t.binary :data

      t.timestamps
    end
  end
end
