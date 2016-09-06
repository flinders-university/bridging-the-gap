class AddOrderToIQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :i_questions, :order, :integer
  end
end
