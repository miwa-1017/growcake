class MypageController < ApplicationController
  before_action :set_current_user
  before_action :forbid_guest, only: [:update]
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, notice: "マイページ情報を更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  private

  def set_current_user
    @user = current_user
    return unless @user
    @exercise_logs = current_user.exercise_logs
    @growth_point = current_user.growth_logs.sum(:growth_point)
  end

  def user_params
    params.require(:user).permit(:name, :cake_type)
  end
end