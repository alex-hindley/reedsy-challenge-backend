_merch1 = MerchItem.create(code: "MUG", name: "Reedsy Mug", price: 6.0)
_merch2 = MerchItem.create(code: "TSHIRT", name: "Reedsy T-shirt", price: 15.0)
_merch3 = MerchItem.create(code: "HOODIE", name: "Reedsy Hoodie", price: 20.0)

# T-shirt discount
_volume_discount1 = VolumeDiscount.create(merch_item_id: 2, percentage: 0.3, min_volume: 3)

# Incremental mug discounts
(1..15).map { |i| i * 10 }.each do |v|
  max_volume = (v < 150) ? v + 9 : nil
  VolumeDiscount.create(
    merch_item_id: 1,
    min_volume: v,
    max_volume: max_volume,
    percentage: ((v / 10) * 0.02)
  )
end
