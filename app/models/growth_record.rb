class GrowthRecord < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_one_attached :image

  validates :date, presence: true
  validates :stage, presence: true
end