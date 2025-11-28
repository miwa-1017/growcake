class AddTotalPointsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :total_points, :integer, default: 0
  end
end
