require 'test_helper'

class SettingControllerTest < ActionController::TestCase
  test "should get root" do
    get :root
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

end
