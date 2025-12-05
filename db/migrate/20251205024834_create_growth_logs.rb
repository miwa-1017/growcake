class CreateGrowthLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :growth_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :growth_point, default: 0

      t.timestamps
    end
  end
end
