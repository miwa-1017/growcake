class AddCommentToGrowthRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :growth_records, :comment, :text
  end
end
