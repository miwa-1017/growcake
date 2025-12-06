module ApplicationHelper
  def cake_type_name(type)
    case type
    when "tarte" then "タルト"
    when "shortcake" then "ショートケーキ"
    else "未設定"
    end
  end
end
