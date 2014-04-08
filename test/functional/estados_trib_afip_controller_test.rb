require 'test_helper'

class EstadosTribAfipControllerTest < ActionController::TestCase
  setup do
    @estado_trib_afip = estados_trib_afip(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:estados_trib_afip)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create estado_trib_afip" do
    assert_difference('EstadoTribAfip.count') do
      post :create, estado_trib_afip: { clave: @estado_trib_afip.clave, condicion: @estado_trib_afip.condicion, fechaAlta: @estado_trib_afip.fechaAlta }
    end

    assert_redirected_to estado_trib_afip_path(assigns(:estado_trib_afip))
  end

  test "should show estado_trib_afip" do
    get :show, id: @estado_trib_afip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @estado_trib_afip
    assert_response :success
  end

  test "should update estado_trib_afip" do
    put :update, id: @estado_trib_afip, estado_trib_afip: { clave: @estado_trib_afip.clave, condicion: @estado_trib_afip.condicion, fechaAlta: @estado_trib_afip.fechaAlta }
    assert_redirected_to estado_trib_afip_path(assigns(:estado_trib_afip))
  end

  test "should destroy estado_trib_afip" do
    assert_difference('EstadoTribAfip.count', -1) do
      delete :destroy, id: @estado_trib_afip
    end

    assert_redirected_to estados_trib_afip_path
  end
end
