class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :exercise_logs, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :growth_logs, dependent: :destroy
  has_many :comments
  has_many :growth_records
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :active_relationships,
          class_name: "Relationship",
          foreign_key: "follower_id",
          dependent: :destroy

  has_many :passive_relationships,
          class_name: "Relationship",
          foreign_key: "followed_id",
          dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :notifications, dependent: :destroy
  has_one_attached :profile_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, presence: true, unless: :guest?

  def active_for_authentication?
    super && !is_deleted && !is_banned
  end

  def email_required?
    !is_deleted
  end

  enum cake_type: { unset: 0, tart: 1, cake: 2 }

   GROWTH_STAGES = {
    tart: [10, 20, 30, 40, 50, 60, 70, 80, 90],    
    cake: [10, 20, 30, 40, 50, 60, 70, 80, 90] 
  }

  # 現在の合計ポイント
  def total_growth_point
    growth_logs.sum(:growth_point)
  end

  # 現在の成長段階
 def current_stage
    return 0 if cake_type == "unset" # 未選択時

    stages = GROWTH_STAGES[cake_type.to_sym]

    # 何個のしきい値を「超えているか」でステージを決定
    # 0〜9 の整数が返る
    stages.count { |threshold| total_growth_point >= threshold }
  end

  def growth_finished?
    return false if cake_type == "unset"

    # ステージ9が最後（配列の長さ = 9）
    current_stage == GROWTH_STAGES[cake_type.to_sym].size
  end

  def cake_image_for_display
    # ケーキタイプ未選択のときは枠だけにする
    return "cakes/cake_frame.png" if cake_type == "unset"

    # shortcake → cake_, tarte → tart_ に対応
    prefix =
      case cake_type
      when "shortcake" then "cake"
      when "tarte"     then "tart"
      else "cake"
      end

    # current_stage は 0〜8 なので、画像名 01〜09 に合わせる
    stage_no  = current_stage         # 1〜9
    stage_str = format("%02d", stage_no)   # "01"〜"09"

    "cakes/#{prefix}_stage_#{stage_str}.png"
  end

  def guest?
    email == 'guest@example.com'
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

  def admin?
    self.admin == true
  end

  def liked?(post)
  likes.exists?(post_id: post.id)
  end

  def follow(other_user)
    active_relationships.create(followed: other_user)
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

end
