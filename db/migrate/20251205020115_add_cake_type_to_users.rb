class AddCakeTypeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :cake_type, :integer
  end
end
