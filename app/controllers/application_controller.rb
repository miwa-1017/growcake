class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

   helper_method :guest_user?

protected


  def after_sign_up_path_for(resource)
    flash[:notice] = "はじめまして 🌱 Grow Cakeへようこそ"
    root_path
  end

  def after_sign_in_path_for(resource)
    flash[:notice] ||= "今日もGrow Cakeへようこそ 🍰"
    super
  end

  def after_sign_out_path_for(resource_or_scope)
    flash[:notice] = "今日もおつかれさまでした 🌙"
    super
  end

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
