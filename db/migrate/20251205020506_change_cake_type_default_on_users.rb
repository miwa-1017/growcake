class ChangeCakeTypeDefaultOnUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :cake_type, 0
    change_column_null :users, :cake_type, false, 0
  end
end