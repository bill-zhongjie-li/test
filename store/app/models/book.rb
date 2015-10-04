class Book < Item
  has_many :chapters, foreign_key: :item_id, dependent: :destroy
end
