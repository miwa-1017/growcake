class ExerciseLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :forbid_guest

  def index
    @exercise_logs = current_user.exercise_logs.order(created_at: :desc)
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

      redirect_to exercise_logs_path, notice: "おつかれさま +#{points}pt 🏋️‍♀️✨"
    else
      render :new
    end
  end

  private

  def exercise_log_params
    params.require(:exercise_log).permit(:category, :minutes)
  end
end