class CreateStc2016s < ActiveRecord::Migration[5.0]
  def change
    create_table :stc2016s do |t|
      t.string :name
      t.integer :degreeyear
      t.string :email
      t.boolean :plusone
      t.string :plusone_name

      t.timestamps
    end
  end
end
