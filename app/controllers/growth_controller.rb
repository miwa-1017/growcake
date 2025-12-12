class GrowthController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_cake_selected

  def show
    @user = current_user
    @total_points = @user.total_growth_point
    @stage = @user.current_stage   # ← これだけにする！
  end

  private

  def ensure_cake_selected
    if current_user.cake_type == "unset" || current_user.cake_type.nil?
      redirect_to edit_cake_type_path, alert: "まだケーキ決まってないみたい。先に選んで育てよう🐰"
    end
  end
end