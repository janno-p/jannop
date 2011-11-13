require 'test_helper'

class ActionsControllerTest < ActionController::TestCase
  test "should get view" do
    get :view
    assert_response :success
  end

end
