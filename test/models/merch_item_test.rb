require "test_helper"

class MerchItemTest < ActiveSupport::TestCase
  test "should not save merch item without code, name, and price" do
    item = MerchItem.new
    assert_not(item.save, "can't save merch item without code, name, and price")
  end
end
