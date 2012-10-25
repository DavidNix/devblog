require 'test_helper'

class SocialIconsControllerTest < ActionController::TestCase
  test "should get rss" do
    get :rss
    assert_response :success
  end

  test "should get email" do
    get :email
    assert_response :success
  end

  test "should get twitter" do
    get :twitter
    assert_response :success
  end

end
