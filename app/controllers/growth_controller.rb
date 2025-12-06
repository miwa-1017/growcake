class GrowthController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    stages = User::GROWTH_STAGES[@user.cake_type.to_sym]
    @total_points = @user.total_growth_point

    # ★成長段階の決め方（境界値以内で最初に一致した位置）
    @stage = stages.index { |point| @total_points < point } || stages.length - 1
  end
end
