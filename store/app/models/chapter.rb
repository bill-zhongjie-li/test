class Chapter < ActiveRecord::Base
  belongs_to :book, foreign_key: :item_id

  validates :name, presence: true
end
