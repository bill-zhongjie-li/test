class Cd < Item
  has_many :tracks, foreign_key: :item_id, dependent: :destroy
end
