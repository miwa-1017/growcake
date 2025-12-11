class ChangeCakeTypeNullable < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :cake_type, true
  end
end