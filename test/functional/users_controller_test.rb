require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  fixtures :users
  
  setup do
    @user = users(:toivo)
  end

=begin
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: @user.attributes
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: @user.attributes
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
=end
  
  test "index without user" do
    get :index
    assert_redirected_to new_session_path
    assert_equal "Please log in!", flash[:notice]
  end
  
  test "index with active user" do
    get :index, {}, { :user_id => @user.id }
    assert_response :success
    assert_template :index
  end
  
  test "index with inactive user" do
    get :index, {}, { :user_id => users(:mauno).id }
    assert_redirected_to root_path
    assert_equal "User mauno@openid.test is not ativated yet. Try again later!", flash[:notice]
  end
end
