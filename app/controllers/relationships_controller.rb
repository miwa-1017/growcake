class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)

    respond_to do |format|
      format.js
    end
  end

  def destroy
    relationship = Relationship.find(params[:id])

    # 念のためのガード
    return head :forbidden unless relationship.follower == current_user

    @user = relationship.followed
    relationship.destroy

    respond_to do |format|
      format.js
    end
  end
end