class ChangePublicColumnOnBlogs < ActiveRecord::Migration[5.0]
  def change
    remove_column :blogs, :public
    remove_column :blogs, :body
    add_column :blogs, :body, :text
    add_column :blogs, :public, :boolean
  end
end
