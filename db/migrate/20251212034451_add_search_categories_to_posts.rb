class AddSearchCategoriesToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :search_categories, :text
  end
end
