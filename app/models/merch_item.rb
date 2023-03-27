class MerchItem < ApplicationRecord
  validates :code, presence: true
  validates :name, presence: true
  validates :price, presence: true
end
