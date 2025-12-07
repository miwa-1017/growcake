class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :exercise_logs, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :growth_logs, dependent: :destroy
  has_many :comments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, unless: :guest?

  enum cake_type: { unset: 0, tarte: 1, shortcake: 2 }

   GROWTH_STAGES = {
    tarte:     [0, 10, 20, 30, 40, 50, 60, 70, 80],    
    shortcake: [0, 10, 20, 30, 40, 50, 60, 70, 80] 
  }

  # 現在の合計ポイント
  def total_growth_point
    growth_logs.sum(:growth_point)
  end

  # 現在の成長段階
  def current_stage
    return 0 if cake_type == "unset" # 未選択時

    stages = GROWTH_STAGES[cake_type.to_sym]

    stages.each_with_index do |threshold, index|
      return index if total_growth_point < threshold
    end

    stages.size - 1 # 最終ステージ
  end

  def growth_finished?
    return false if cake_type == "unset"
    current_stage == GROWTH_STAGES[cake_type&.to_sym].length - 1
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
    stage_no  = current_stage + 1          # 1〜9
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

end
