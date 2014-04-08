require 'test_helper'

class CuentasCorrientesControllerTest < ActionController::TestCase
  setup do
    @cuenta_corriente = cuentas_corrientes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cuentas_corrientes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cuenta_corriente" do
    assert_difference('CuentaCorriente.count') do
      post :create, cuenta_corriente: { descripcion: @cuenta_corriente.descripcion }
    end

    assert_redirected_to cuenta_corriente_path(assigns(:cuenta_corriente))
  end

  test "should show cuenta_corriente" do
    get :show, id: @cuenta_corriente
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cuenta_corriente
    assert_response :success
  end

  test "should update cuenta_corriente" do
    put :update, id: @cuenta_corriente, cuenta_corriente: { descripcion: @cuenta_corriente.descripcion }
    assert_redirected_to cuenta_corriente_path(assigns(:cuenta_corriente))
  end

  test "should destroy cuenta_corriente" do
    assert_difference('CuentaCorriente.count', -1) do
      delete :destroy, id: @cuenta_corriente
    end

    assert_redirected_to cuentas_corrientes_path
  end
end
