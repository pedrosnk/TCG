require 'test_helper'

class ExpansionsControllerTest < ActionController::TestCase
  setup do
    @expansion = expansions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expansions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expansion" do
    assert_difference('Expansion.count') do
      post :create, expansion: @expansion.attributes
    end

    assert_redirected_to expansion_path(assigns(:expansion))
  end

  test "should show expansion" do
    get :show, id: @expansion.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @expansion.to_param
    assert_response :success
  end

  test "should update expansion" do
    put :update, id: @expansion.to_param, expansion: @expansion.attributes
    assert_redirected_to expansion_path(assigns(:expansion))
  end

  test "should destroy expansion" do
    assert_difference('Expansion.count', -1) do
      delete :destroy, id: @expansion.to_param
    end

    assert_redirected_to expansions_path
  end
end
