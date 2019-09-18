class AddSummaryToBlogs < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :summary, :text
  end
end
