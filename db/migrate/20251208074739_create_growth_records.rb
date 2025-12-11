class CreateGrowthRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :growth_records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.integer :stage
      t.date :date

      t.timestamps
    end
  end
end
