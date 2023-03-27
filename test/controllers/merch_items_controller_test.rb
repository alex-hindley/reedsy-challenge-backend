require "test_helper"

class MerchItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @merch_item = merch_items(:one)
  end

  test "should get index" do
    get merch_items_url, as: :json
    assert_response :success
  end

  test "should not create merch_item with no code" do
    assert_difference("MerchItem.count", 0) do
      post merch_items_url, params: {merch: {name: "Test Item", price: 1.0}}, as: :json
    end
    assert_response :success
  end

  test "should not create merch_item with no name" do
    assert_difference("MerchItem.count", 0) do
      post merch_items_url, params: {merch: {code: "TEST", price: 1.0}}, as: :json
    end
    assert_response :success
  end

  test "should not create merch_item with no price" do
    assert_difference("MerchItem.count", 0) do
      post merch_items_url, params: {merch: {code: "TEST", name: "Test Item"}}, as: :json
    end
    assert_response :success
  end

  test "should create merch_item with code, name, price" do
    assert_difference("MerchItem.count") do
      post merch_items_url, params: {merch: {code: "TEST", name: "Test Item", price: 13.0}}, as: :json
    end
    assert_response :success
  end

  test "should show merch_item" do
    get merch_item_url(@merch_item), as: :json
    assert_response :success
  end

  test "should update merch_item price" do
    patch merch_item_url(@merch_item), params: {merch: {price: 7.5}}, as: :json
    assert_response :success
  end

  test "should destroy merch_item" do
    assert_difference("MerchItem.count", -1) do
      delete merch_item_url(@merch_item), as: :json
    end
    assert_response :no_content
  end
end
