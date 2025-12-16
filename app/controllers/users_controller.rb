class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    if @user.is_deleted?
      raise ActiveRecord::RecordNotFound
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice:"プロフィールを更新しました"
    else
      render :edit
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

  def following
    @user = User.find(params[:id])
    @users = @user.following
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  private

  def admin_only
    redirect_to root_path, alert: "権限がありません。" unless current_user.admin?
  end

  def set_user
    @user = current_user
  end

  def user_params
      params.require(:user).permit(
        :name,
        :profile_image,
        :favorite_cake,
        :favorite_shop,
        :introduction
      )
  end
  
end