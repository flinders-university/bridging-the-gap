class AddFocusGroupIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :focus_group_id, :integer
  end
end
