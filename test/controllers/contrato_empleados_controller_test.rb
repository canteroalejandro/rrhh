require 'test_helper'

class ContratoEmpleadosControllerTest < ActionController::TestCase
  setup do
    @contrato_empleado = contrato_empleados(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contrato_empleados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contrato_empleado" do
    assert_difference('ContratoEmpleado.count') do
      post :create, contrato_empleado: { inicio: @contrato_empleado.inicio }
    end

    assert_redirected_to contrato_empleado_path(assigns(:contrato_empleado))
  end

  test "should show contrato_empleado" do
    get :show, id: @contrato_empleado
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contrato_empleado
    assert_response :success
  end

  test "should update contrato_empleado" do
    patch :update, id: @contrato_empleado, contrato_empleado: { inicio: @contrato_empleado.inicio }
    assert_redirected_to contrato_empleado_path(assigns(:contrato_empleado))
  end

  test "should destroy contrato_empleado" do
    assert_difference('ContratoEmpleado.count', -1) do
      delete :destroy, id: @contrato_empleado
    end

    assert_redirected_to contrato_empleados_path
  end
end
