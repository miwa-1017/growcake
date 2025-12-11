class ChangeCakeTypeDefaultToUnset < ActiveRecord::Migration[6.1]
  def change

    change_column_default :users, :cake_type, 0
  end
end
