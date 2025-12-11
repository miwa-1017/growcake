require "test_helper"

class GrowthRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get growth_records_index_url
    assert_response :success
  end
end
