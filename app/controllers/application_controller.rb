class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

   helper_method :guest_user?

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def guest_user?
  current_user.email == "guest@example.com"
  end

  def forbid_guest
    if user_signed_in? && current_user.email == "guest@example.com"
      redirect_to posts_path, alert: "ゲストユーザーは閲覧のみ可能です。"
    end
  end
end
