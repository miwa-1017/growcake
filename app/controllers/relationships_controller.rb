class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    relationship = current_user.active_relationships.find(params[:id])
    relationship.destroy
    redirect_back(fallback_location: root_path)
  end
end
