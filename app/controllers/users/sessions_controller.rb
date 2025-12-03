class Users::SessionsController < ApplicationController
  def guest_sign_in
    user = User.find_or_create_by(email: "guest@example.com") do |u|
      u.password = SecureRandom.urlsafe_base64
      u.name = "ゲストユーザー"
    end

    # ゲストログイン時に投稿 & ポイントをリセット
    user.exercise_logs.destroy_all
    user.update(total_points: 0)

    sign_in user
    redirect_to exercise_logs_path, notice: "ゲストログインしました🧁"
  end

  def destroy
    if current_user.email == "guest@example.com"
      current_user.exercise_logs.destroy_all
      current_user.update(total_points: 0) 
    end

    super
  end
end