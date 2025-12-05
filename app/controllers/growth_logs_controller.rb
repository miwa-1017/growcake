class GrowthLogsController < ApplicationController
  before_action :authenticate_user!

  def new
    redirect_to growth_path
  end

  def create
    @growth_log = GrowthLog.new(growth_log_params)
    @growth_log.user_id = current_user.id

    if @growth_log.save
      redirect_to growth_path, notice: "ケーキが成長しました！"
    else
      redirect_to growth_path, alert: "保存できませんでした"
    end
  end

  def show
    @growth_log = GrowthLog.find(params[:id])
  end

  private

  def growth_log_params
    params.require(:growth_log).permit(:level, :training_count)
  end
end