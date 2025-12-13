class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :reject_guest, only: [:index]

  def create
    current_user.likes.find_or_create_by(post_id: params[:post_id])
    redirect_back(fallback_location: root_path)
  end

  def index
    @likes = current_user.likes.includes(:post)
  end

  def destroy
    like = current_user.likes.find_by(post_id: params[:post_id])
    like.destroy if like
    redirect_back(fallback_location: root_path)
  end

  private

  def reject_guest
    redirect_to root_path if current_user.guest?
  end
end