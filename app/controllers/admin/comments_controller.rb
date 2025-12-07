module Admin
  class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_only

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_back fallback_location: admin_users_path, notice: "コメントを削除しました。"
    end

    private

    def admin_only
      redirect_to root_path, alert: "権限がありません。" unless current_user.admin?
    end
  end
end