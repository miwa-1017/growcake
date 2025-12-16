class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :reject_guest, only: [:index]

  def create
    @post = Post.find(params[:post_id])
    current_user.likes.find_or_create_by(post: @post)

    respond_to do |format|
      format.js
    end
  end

  def index
    @likes = current_user.likes.includes(:post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post: @post)
    like.destroy if like

    respond_to do |format|
      format.js
      format.html { redirect_back(fallback_location: likes_path) }
    end
  end

  private

  def reject_guest
    redirect_to root_path if current_user.guest?
  end
end