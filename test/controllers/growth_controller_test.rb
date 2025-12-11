require "test_helper"

class GrowthControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get growth_show_url
    assert_response :success
  end
end
