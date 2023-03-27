require "test_helper"

class MerchHelperTest < ActiveSupport::TestCase
  include MerchHelper

  test "pretty price check 1 mug" do
    quantities = {1 => 1}
    result = pretty_price_check(quantities)

    assert_equal("Items: 1 MUG\nTotal: 6.00", result, "pretty price check inaccurate")
  end

  test "pretty price check 3 mugs" do
    quantities = {1 => 3}
    result = pretty_price_check(quantities)

    assert_equal("Items: 3 MUG\nTotal: 18.00", result, "pretty price check inaccurate")
  end

  test "pretty price check 9 mug, 1 t-shirt" do
    quantities = {1 => 9, 2 => 1}
    result = pretty_price_check(quantities)

    assert_equal("Items: 9 MUG, 1 TSHIRT\nTotal: 69.00", result, "pretty price check inaccurate")
  end

  test "pretty price check 10 mug, 1 t-shirt (apply discount)" do
    quantities = {1 => 10, 2 => 1}
    result = pretty_price_check(quantities)

    expected_message = "Items: 10 MUG, 1 TSHIRT\n" \
      "Total: 73.80\n\n" \
      "Explanation:\n" \
      "\t- Total without discount: 60.00 + 15.00 = 75.00\n" \
      "\t- Discount: 1.20 (2% discount on MUG)\n" \
      "\t- Total: 75.00 - 1.20 = 73.80"

    assert_equal(expected_message, result, "pretty price check inaccurate")
  end

  test "pretty price check 10 mug, 6 tshirt (apply multiple discounts)" do
    quantities = {1 => 10, 2 => 6}
    result = pretty_price_check(quantities)

    expected_message = "Items: 10 MUG, 6 TSHIRT\n" \
      "Total: 121.80\n\n" \
      "Explanation:\n" \
      "\t- Total without discount: 60.00 + 90.00 = 150.00\n" \
      "\t- Discount: 1.20 (2% discount on MUG) + 27.00 (30% discount on TSHIRT)\n" \
      "\t- Total: 150.00 - 28.20 = 121.80"

    assert_equal(expected_message, result, "pretty price check inaccurate")
  end

  test "pretty price check 200 mug, 4 tshirt, 1 hoodie (apply multiple discounts)" do
    quantities = {1 => 200, 2 => 4, 3 => 1}
    result = pretty_price_check(quantities)

    expected_message = "Items: 200 MUG, 4 TSHIRT, 1 HOODIE\n" \
      "Total: 902.00\n\n" \
      "Explanation:\n" \
      "\t- Total without discount: 1200.00 + 60.00 + 20.00 = 1280.00\n" \
      "\t- Discount: 360.00 (30% discount on MUG) + 18.00 (30% discount on TSHIRT)\n" \
      "\t- Total: 1280.00 - 378.00 = 902.00"

    assert_equal(expected_message, result, "pretty price check inaccurate")
  end

  test "price calculator: 1 mug, 1 t-shirt, 1 hoodie" do
    quantities = {1 => 1, 2 => 1, 3 => 1}
    price, display_item_totals = price_calculator(quantities)

    assert_equal(41.0, price, "incorrect total")
    assert_equal("6.00 + 15.00 + 20.00", display_item_totals, "item totals not formatting correctly")
  end

  test "price calculator: 2 mug, 1 t-shirt" do
    quantities = {1 => 2, 2 => 1}
    price, display_item_totals = price_calculator(quantities)

    assert_equal(27.0, price, "incorrect total")
    assert_equal("12.00 + 15.00", display_item_totals, "item totals not formatting correctly")
  end

  test "price calculator: 3 mug, 1 t-shirt" do
    quantities = {1 => 3, 2 => 1}
    price, display_item_totals = price_calculator(quantities)

    assert_equal(33.0, price, "incorrect total")
    assert_equal("18.00 + 15.00", display_item_totals, "item totals not formatting correctly")
  end

  test "price calculator: 2 mug, 4 t-shirt, 1 hoodie" do
    quantities = {1 => 2, 2 => 4, 3 => 1}
    price, display_item_totals = price_calculator(quantities)

    assert_equal(92.0, price, "incorrect total")
    assert_equal("12.00 + 60.00 + 20.00", display_item_totals, "item totals not formatting correctly")
  end

  test "discount calculator: 1 mug, 1 t-shirt, 1 hoodie" do
    quantities = {1 => 1, 2 => 1, 3 => 1}
    discount, discount_details = discount_calculator(quantities)

    assert_equal(0, discount, "incorrect discount")
    assert_not(discount_details, "should be no discount details to show")
  end

  test "discount calculator: 9 mug, 1 t-shirt" do
    quantities = {1 => 9, 2 => 1}
    discount, discount_details = discount_calculator(quantities)

    assert_equal(0, discount, "incorrect discount")
    assert_not(discount_details, "should be no discount details to show")
  end

  test "discount calculator: 10 mug, 1 t-shirt" do
    quantities = {1 => 10, 2 => 1}
    discount, discount_details = discount_calculator(quantities)

    assert_equal(1.2, discount, "incorrect discount")
    assert_equal("1.20 (2% discount on MUG)", discount_details, "should be no discount details to show")
  end

  test "discount calculator: 45 mug, 3 t-shirt" do
    quantities = {1 => 45, 2 => 3}
    discount, discount_details = discount_calculator(quantities)

    assert_equal(35.1, discount, "incorrect discount")
    assert_equal("21.60 (8% discount on MUG) + 13.50 (30% discount on TSHIRT)", discount_details, "should be no discount details to show")
  end

  test "discount calculator: 200 mug, 4 t-shirt, 1 hoodie" do
    quantities = {1 => 200, 2 => 4, 3 => 1}
    discount, discount_details = discount_calculator(quantities)

    assert_equal(378.0, discount, "incorrect discount")
    assert_equal("360.00 (30% discount on MUG) + 18.00 (30% discount on TSHIRT)", discount_details, "should be no discount details to show")
  end
end
