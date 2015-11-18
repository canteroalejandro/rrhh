require 'test_helper'

class HorarioEmpleadosControllerTest < ActionController::TestCase
  setup do
    @horario_empleado = horario_empleados(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:horario_empleados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create horario_empleado" do
    assert_difference('HorarioEmpleado.count') do
      post :create, horario_empleado: {  }
    end

    assert_redirected_to horario_empleado_path(assigns(:horario_empleado))
  end

  test "should show horario_empleado" do
    get :show, id: @horario_empleado
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @horario_empleado
    assert_response :success
  end

  test "should update horario_empleado" do
    patch :update, id: @horario_empleado, horario_empleado: {  }
    assert_redirected_to horario_empleado_path(assigns(:horario_empleado))
  end

  test "should destroy horario_empleado" do
    assert_difference('HorarioEmpleado.count', -1) do
      delete :destroy, id: @horario_empleado
    end

    assert_redirected_to horario_empleados_path
  end
end
