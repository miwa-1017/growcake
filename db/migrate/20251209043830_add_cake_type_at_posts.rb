class AddCakeTypeAtPosts < ActiveRecord::Migration[6.1]
  def change
add_column :posts, :cake_type_at_post, :stiring
  
  end
end
