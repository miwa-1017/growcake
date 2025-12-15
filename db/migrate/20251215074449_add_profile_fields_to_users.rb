class AddProfileFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :favorite_cake, :string
    add_column :users, :favorite_shop, :string
    add_column :users, :introduction, :text
  end
end
