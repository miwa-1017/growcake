class RenameCakeTypeToCakeTypeAtPostInGrowthRecords < ActiveRecord::Migration[6.1]
  def change
    rename_column :growth_records, :cake_type, :cake_type_at_post
  end
end
