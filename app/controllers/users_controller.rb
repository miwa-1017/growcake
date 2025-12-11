class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    if @user.is_deleted?
      raise ActiveRecord::RecordNotFound
    end
  end


  def index
    if params[:keyword].present?
      @users = User.where("name LIKE ?", "%#{params[:keyword]}%")
    else
      @users = User.all
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "ユーザーを削除しました。"
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)

    reset_session  # ログアウトさせる
    redirect_to root_path, notice: "退会処理が完了しました。またいつでも戻ってきてね "
  end

  private

  def admin_only
    redirect_to root_path, alert: "権限がありません。" unless current_user.admin?
  end
end