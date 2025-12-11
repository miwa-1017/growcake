class AddGrowthFinishedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :growth_finished, :boolean
    add_column :users, :default, :integer
  end
end
