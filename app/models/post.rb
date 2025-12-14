class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :growth_records
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :notifications, as: :notifiable, dependent: :destroy
  serialize :search_categories, Array
end
