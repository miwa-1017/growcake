require "test_helper"

class CakeTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get cake_types_edit_url
    assert_response :success
  end

  test "should get update" do
    get cake_types_update_url
    assert_response :success
  end
end
