class Item < ActiveRecord::Base
  validates :title, :author, :type, presence: true
  validates :year, presence: true, numericality: { only_integer: true }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
