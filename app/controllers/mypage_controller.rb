class MypageController < ApplicationController
  before_action :set_current_user

  def show
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, notice: "ケーキタイプを更新しました"
    else
      render :show, alert: "更新に失敗しました"
    end
  end

  def edit
    @user = current_user
  end

  private

  def set_current_user
    @user = current_user
    @exercise_logs = current_user.exercise_logs
    @growth_point = current_user.growth_logs.sum(:growth_point)
  end

  def user_params
    params.permit(:cake_type)
  end
end