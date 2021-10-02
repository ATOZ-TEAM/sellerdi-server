require "test_helper"

class Api::ShopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shop = shops(:one)
  end

  test "should get index" do
    get api_shops_url
    assert_response :success
  end

  test "should get new" do
    get new_api_shop_url
    assert_response :success
  end

  test "should create shop" do
    assert_difference('Shop.count') do
      post api_shops_url, params: { shop: {  } }
    end

    assert_redirected_to shop_url(Shop.last)
  end

  test "should show shop" do
    get api_shop_url(@shop)
    assert_response :success
  end

  test "should get edit" do
    get edit_api_shop_url(@shop)
    assert_response :success
  end

  test "should update shop" do
    patch api_shop_url(@shop), params: { shop: {  } }
    assert_redirected_to shop_url(@shop)
  end

  test "should destroy shop" do
    assert_difference('Shop.count', -1) do
      delete api_shop_url(@shop)
    end

    assert_redirected_to api_shops_url
  end
end
