class Track < ActiveRecord::Base
  belongs_to :cd, foreign_key: :item_id

  validates :name, presence: true
  validates :seconds, presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
