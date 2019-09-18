class AddShowInfoToIndustry < ActiveRecord::Migration[5.0]
  def change
    add_column :industries, :show_info, :boolean
  end
end
