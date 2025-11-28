class CreateExerciseLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :exercise_logs do |t|
      t.integer :category
      t.integer :minutes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
