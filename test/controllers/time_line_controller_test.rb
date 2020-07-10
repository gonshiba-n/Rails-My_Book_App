require 'test_helper'

class TimeLineControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get time_line_index_url
    assert_response :success
  end

  test "should get show" do
    get time_line_show_url
    assert_response :success
  end
end
