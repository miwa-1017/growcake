class ExerciseLog < ApplicationRecord
  belongs_to :user

  enum category: { strength: 0, cardio: 1, stretch: 2 }

  validates :minutes, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def calculate_points
    rate = case category
           when "strength" then 2
           when "cardio"   then 1
           when "stretch"  then 0.5
           end

    (minutes / 10.0 * rate).round
  end

  def index
    @exercise_logs = current_user.exercise_logs
  end
end