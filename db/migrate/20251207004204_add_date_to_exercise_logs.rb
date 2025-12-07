class AddDateToExerciseLogs < ActiveRecord::Migration[6.1]
  def change
    add_column :exercise_logs, :date, :date
  end
end
