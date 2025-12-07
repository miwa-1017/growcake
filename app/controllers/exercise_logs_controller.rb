class ExerciseLogsController < ApplicationController
  before_action :limit_guest_post, only: [:create]

  def index
    @exercise_logs = current_user.exercise_logs
  end

  def new
    @exercise_log = ExerciseLog.new
  end

  def create
    @exercise_log = current_user.exercise_logs.new(exercise_log_params)

    @exercise_log.date = Date.today

    if @exercise_log.save
      points = @exercise_log.calculate_points
      current_user.increment!(:total_points, points)
      #成長ポイント履歴を保存
      current_user.growth_logs.create(growth_point: points)

      redirect_to exercise_logs_path, notice: "運動ログ追加！ +#{points}pt 🏋️‍♀️✨"
    else
      render :new
    end
  end

  private

  # 🧁ゲストは1回だけ投稿可能
  def limit_guest_post
    if current_user.email == "guest@example.com" && current_user.exercise_logs.exists?
      redirect_to exercise_logs_path, alert: "ゲストユーザーは1回のみ投稿できます🍰 続ける場合は会員登録してください💗"
    end
  end

  def exercise_log_params
    params.require(:exercise_log).permit(:category, :minutes)
  end
end