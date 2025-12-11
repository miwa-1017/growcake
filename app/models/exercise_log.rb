class ExerciseLog < ApplicationRecord
  belongs_to :user

  enum category: {
  cardio: 0,        # 有酸素
  running: 1,       # ランニング
  strength: 2,      # 筋トレ
  stretch: 3,       # ストレッチ
  walking: 4,       # ウォーキング
  yoga: 5,          # ヨガ
  dance: 6,         # ダンス
  pilates: 7,       # ピラティス
  ems: 8            # EMS
  }

  validates :minutes, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def calculate_points
    rates = {
      "cardio" => 1,
      "running" => 2.2,
      "strength" => 2,
      "stretch" => 0.5,
      "walking" => 1,
      "yoga" => 0.7,
      "dance" => 1.3,
      "pilates" => 1.2,
      "ems" => 0.4
    }

    (minutes / 10.0 * rates[category]).round
  end

  def index
    @exercise_logs = current_user.exercise_logs
  end
end