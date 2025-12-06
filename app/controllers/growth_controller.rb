class GrowthController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_cake_selected

  def show
    @user = current_user
    stages = User::GROWTH_STAGES[@user.cake_type.to_sym]
    @total_points = @user.total_growth_point

    # 成長段階を決めるロジック
    @stage = stages.index { |point| @total_points <= point } || stages.length - 1
  end

  private

  def ensure_cake_selected
    if current_user.cake_type == "unset" || current_user.cake_type.nil?
      redirect_to edit_cake_type_path, alert: "まだケーキ決まってないみたい。先に選んで育てよう🐰"
    end
  end
end