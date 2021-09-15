require "test_helper"

class Api::Exchange::ReadControllerTest < ActionDispatch::IntegrationTest
  test "should get all" do
    get api_exchange_read_all_url
    assert_response :success
  end
end
