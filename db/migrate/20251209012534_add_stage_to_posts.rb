class AddStageToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :stage, :integer
  end
end
