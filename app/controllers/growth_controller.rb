class GrowthController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @stage = @user.current_stage
    @total_points = @user.total_growth_point
  end
end
