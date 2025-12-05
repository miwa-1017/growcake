class GrowthLog < ApplicationRecord
  belongs_to :user

  validates :growth_point, numericality: { greater_than_or_equal_to: 0 }
end
