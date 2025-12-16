# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 管理者ユーザー
User.find_or_create_by!(email: "admin@gmail.com") do |user|
  user.name = "admin"
  user.password = "password"
  user.password_confirmation = "password"
  user.admin = true
end

User.find_or_create_by!(email: "guest@example.com") do |user|
  user.name = "ゲスト"
  user.password = SecureRandom.urlsafe_base64
end