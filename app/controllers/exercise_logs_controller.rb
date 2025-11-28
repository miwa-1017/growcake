class ExerciseLogsController < ApplicationController
  def index
    @exercise_logs = current_user.exercise_logs
  end

  def new
    @exercise_log = ExerciseLog.new
  end

  def create
    @exercise_log = current_user.exercise_logs.new(exercise_log_params)

    if @exercise_log.save
      points = @exercise_log.calculate_points
      current_user.increment!(:total_points, points)
      redirect_to exercise_logs_path, notice: "運動ログ追加！ +#{points}pt ✨"
    else
      render :new
    end
  end

  private

  def exercise_log_params
    params.require(:exercise_log).permit(:category, :minutes)
  end
end