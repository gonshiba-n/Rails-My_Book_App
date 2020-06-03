require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit_user_profile" do
    get users_edit_user_profile_url
    assert_response :success
  end

end
