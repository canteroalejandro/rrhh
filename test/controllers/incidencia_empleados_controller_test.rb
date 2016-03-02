require 'test_helper'

class IncidenciaEmpleadosControllerTest < ActionController::TestCase
  setup do
    @incidencia_empleado = incidencia_empleados(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incidencia_empleados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create incidencia_empleado" do
    assert_difference('IncidenciaEmpleado.count') do
      post :create, incidencia_empleado: { inicio: @incidencia_empleado.inicio }
    end

    assert_redirected_to incidencia_empleado_path(assigns(:incidencia_empleado))
  end

  test "should show incidencia_empleado" do
    get :show, id: @incidencia_empleado
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @incidencia_empleado
    assert_response :success
  end

  test "should update incidencia_empleado" do
    patch :update, id: @incidencia_empleado, incidencia_empleado: { inicio: @incidencia_empleado.inicio }
    assert_redirected_to incidencia_empleado_path(assigns(:incidencia_empleado))
  end

  test "should destroy incidencia_empleado" do
    assert_difference('IncidenciaEmpleado.count', -1) do
      delete :destroy, id: @incidencia_empleado
    end

    assert_redirected_to incidencia_empleados_path
  end
end
