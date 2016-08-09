class AddIndustryIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :industry_id, :integer
  end
end
