class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :exercise_logs, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :growth_logs, dependent: :destroy

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

  def guest?
    email == 'guest@example.com'
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

end
