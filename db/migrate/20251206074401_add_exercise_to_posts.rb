class AddExerciseToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :exercise, :string
  end
end
