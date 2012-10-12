require 'test_helper'

class ErrorControllerTest < ActionController::TestCase
  test "should get error_404" do
    get :error_404
    assert_response :success
  end

  test "should get error_500" do
    get :error_500
    assert_response :success
  end

end
