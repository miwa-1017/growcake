class CakeTypesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    if current_user.update(cake_type_params)
      redirect_to mypage_path, notice: "ケーキタイプを変更しました！🍰"
    else
      render :edit
    end
  end

  private

  def cake_type_params
    params.require(:user).permit(:cake_type)
  end
end