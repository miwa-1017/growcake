class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    redirect_to admin_user_path(@user), notice: "退会処理をしました。"
  end

  def ban
    @user = User.find(params[:id])
    @user.update(is_banned: true)
    redirect_to admin_user_path(@user), alert: "BANしました。（ログイン不可）"
  end

  def unban
    @user = User.find(params[:id])
    @user.update(is_banned: false)
    redirect_to admin_user_path(@user), notice: "BANを解除しました。"
  end

  def destroy
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    redirect_to admin_users_path, notice: "ユーザーを退会処理しました。"
  end

  private

  def admin_only
    redirect_to root_path, alert: "権限がありません。" unless current_user.admin?
  end
end