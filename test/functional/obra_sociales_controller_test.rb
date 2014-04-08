require 'test_helper'

class ObraSocialesControllerTest < ActionController::TestCase
  setup do
    @obra_social = obra_sociales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:obra_sociales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create obra_social" do
    assert_difference('ObraSocial.count') do
      post :create, obra_social: { detalle: @obra_social.detalle, nombre: @obra_social.nombre }
    end

    assert_redirected_to obra_social_path(assigns(:obra_social))
  end

  test "should show obra_social" do
    get :show, id: @obra_social
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @obra_social
    assert_response :success
  end

  test "should update obra_social" do
    put :update, id: @obra_social, obra_social: { detalle: @obra_social.detalle, nombre: @obra_social.nombre }
    assert_redirected_to obra_social_path(assigns(:obra_social))
  end

  test "should destroy obra_social" do
    assert_difference('ObraSocial.count', -1) do
      delete :destroy, id: @obra_social
    end

    assert_redirected_to obra_sociales_path
  end
end
