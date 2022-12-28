require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get user_login_url
    assert_response :success
  end

  test "should get home" do
    get user_home_url
    assert_response :success
  end

end
