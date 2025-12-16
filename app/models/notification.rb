class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true
  scope :unread, -> { where(read: false) }

  def message
    return "" unless notifiable

    case notifiable_type
    when "Like"
      "#{notifiable.user.name} さんがあなたの投稿にいいねしました"
    when "Comment"
      "#{notifiable.user.name} さんがあなたの投稿にコメントしました"
    when "Relationship"
      "#{notifiable.follower.name} さんがあなたをフォローしました"
    else
      ""
    end
  end
end
