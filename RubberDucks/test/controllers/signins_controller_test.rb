require 'test_helper'

class SigninsControllerTest < ActionController::TestCase
  setup do
    @signin = signins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:signins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create signin" do
    assert_difference('Signin.count') do
      post :create, signin: { password: @signin.password, username: @signin.username }
    end

    assert_redirected_to signin_path(assigns(:signin))
  end

  test "should show signin" do
    get :show, id: @signin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @signin
    assert_response :success
  end

  test "should update signin" do
    patch :update, id: @signin, signin: { password: @signin.password, username: @signin.username }
    assert_redirected_to signin_path(assigns(:signin))
  end

  test "should destroy signin" do
    assert_difference('Signin.count', -1) do
      delete :destroy, id: @signin
    end

    assert_redirected_to signins_path
  end
end
