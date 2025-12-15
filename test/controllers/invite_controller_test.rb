require "test_helper"

class InviteControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get invite_index_url
    assert_response :success
  end
end
