
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: [:update, :destroy]

  protected

  def after_update_path_for(resource)
    mypage_path
  end

  private

  def ensure_normal_user
    if resource.email == "guest@example.com"
      redirect_to mypage_path, alert: "ゲストユーザーは変更できません。"
    end
  end
end
  