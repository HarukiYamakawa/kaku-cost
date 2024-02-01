class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { in: 1..15 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :description, length: { maximum: 1000 }
end
