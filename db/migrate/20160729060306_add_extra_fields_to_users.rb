class AddExtraFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :gender, :string
    add_column :users, :age, :integer
    add_column :users, :degree, :string
    add_column :users, :major, :string
  end
end
