class VolumeDiscount < ApplicationRecord
  validates :merch_item_id, presence: true
  validates :percentage, presence: true
  validates :min_volume, presence: true
end
