class AddNegotiationsToIndustry < ActiveRecord::Migration[5.0]
  def change
    add_column :industries, :negotiations, :boolean
  end
end
