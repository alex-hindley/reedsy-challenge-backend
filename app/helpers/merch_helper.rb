module MerchHelper
  include ActionView::Helpers::NumberHelper

  def pretty_price_check(quantities, merch_items = nil)
    merch_items ||= MerchItem.where(id: quantities.keys)

    result = "Items: " + merch_items.collect do |item|
      quantity = quantities[item[:id]]
      "#{quantity} #{item[:code]}"
    end.join(", ")

    price, display_item_totals = price_calculator(quantities, merch_items)
    display_price = number_with_precision(price, precision: 2)

    discount, discount_details = discount_calculator(quantities, merch_items)

    if discount > 0
      discounted_price = price - discount
      display_discount = number_with_precision(discount, precision: 2)
      display_discounted_price = number_with_precision(discounted_price, precision: 2)

      result += "\nTotal: #{number_with_precision(discounted_price, precision: 2)}"
      result += "\n\n"
      result += "Explanation:\n" \
        "\t- Total without discount: #{display_item_totals} = #{display_price}\n" \
        "\t- Discount: #{discount_details}\n" \
        "\t- Total: #{display_price} - #{display_discount} = #{display_discounted_price}"
    else
      result += "\nTotal: #{display_price}"
    end

    result
  end

  def price_calculator(quantities, merch_items = nil)
    merch_items ||= MerchItem.where(id: quantities.keys)
    total = 0
    item_totals = []

    merch_items.each do |item|
      item_total = item[:price] * quantities[item[:id]]
      total += item_total
      item_totals << number_with_precision(item_total, precision: 2)
    end

    [total, item_totals.join(" + ")]
  end

  def discount_calculator(quantities, merch_items = nil)
    merch_items ||= MerchItem.where(id: quantities.keys)

    volume_discounts = VolumeDiscount.where(merch_item_id: quantities.keys).select do |d|
      quantity = quantities[d[:merch_item_id]]
      equal_or_above_min = quantity >= d[:min_volume]
      equal_or_below_max = !d[:max_volume] || quantity <= d[:max_volume]
      equal_or_above_min && equal_or_below_max
    end

    return 0, nil if !volume_discounts.any?

    percent_by_merch_id = volume_discounts.collect { |d| [d[:merch_item_id], d[:percentage]] }.to_h

    discount_by_merch_id = merch_items.collect do |item|
      percentage = percent_by_merch_id[item[:id]]
      [item[:id], percentage ? (item[:price] * quantities[item[:id]] * percentage) : 0]
    end.to_h

    discount_details = merch_items.collect do |item|
      item_discount = discount_by_merch_id[item[:id]]
      if item_discount > 0
        display_percentage = (percent_by_merch_id[item[:id]] * 100).to_i
        display_item_discount = number_with_precision(item_discount, precision: 2)
        "#{display_item_discount} (#{display_percentage}% discount on #{item[:code]})"
      end
    end.compact.join(" + ")

    total_discount = discount_by_merch_id.values.sum

    [total_discount, discount_details]
  end
end
