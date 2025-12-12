class GrowthRecordsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end

    @growth_records = @user.growth_records.includes(:post).order(created_at: :desc)
  end

  def create
    @growth_record = current_user.growth_records.new(growth_record_params)

    if @growth_record.save
      redirect_to growth_records_path, notice: "成長履歴を登録しました。"
    else
      @growth_records = current_user.growth_records.includes(:post).order(date: :desc)
      flash.now[:alert] = "登録に失敗しました。入力内容を確認してください。"
      render :index
    end
  end

  private

  def growth_record_params
    params.require(:growth_record).permit(
      :post_id,
      :stage,
      :date,
      :comment,
      :image
    )
  end
end