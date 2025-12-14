class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :destroy

  after_create :create_notification

  private

  def create_notification
    return if user == post.user
    Notification.create(
      user: post.user,        # 通知を受け取る人（投稿主）
      notifiable: self        # 通知の発生元（このLike）
    )
  end
end