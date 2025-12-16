module NotificationsHelper
  def unread_notifications_count
    current_user.notifications.where(read: false).count
  end
end
