class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications =
      current_user.notifications
                  .includes(:notifiable)
                  .where.not(notifiable: nil)
                  .order(created_at: :desc)
  end

  def show
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)

    case notification.notifiable
    when Comment, Like
      redirect_to post_path(notification.notifiable.post)
    when Relationship
      redirect_to user_path(notification.notifiable.follower)
    else
      redirect_to notifications_path
    end
  end
end