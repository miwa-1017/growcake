class AddCakeTypeToGrowthRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :growth_records, :cake_type, :string
  end
end
