module ApplicationHelper
  def cake_type_name(type)
    case type
    when "tarte" then "タルト"
    when "shortcake" then "ショートケーキ"
    else "未設定"
    end
  end
  
  def exercise_options
    {
      "有酸素" => "cardio",
      "ランニング" => "running",
      "筋トレ" => "strength",
      "ストレッチ" => "stretch",
      "ウォーキング" => "walking",
      "ヨガ" => "yoga",
      "ダンス" => "dance",
      "ピラティス" => "pilates",
      "EMS" => "ems"
    }
  end
end
