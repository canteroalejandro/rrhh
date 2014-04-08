require 'test_helper'

class ServiciosRealizadosControllerTest < ActionController::TestCase
  setup do
    @servicio_realizado = servicios_realizados(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:servicios_realizados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create servicio_realizado" do
    assert_difference('ServicioRealizado.count') do
      post :create, servicio_realizado: { bonificacion: @servicio_realizado.bonificacion, descripcion: @servicio_realizado.descripcion, fecha: @servicio_realizado.fecha, monto: @servicio_realizado.monto }
    end

    assert_redirected_to servicio_realizado_path(assigns(:servicio_realizado))
  end

  test "should show servicio_realizado" do
    get :show, id: @servicio_realizado
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @servicio_realizado
    assert_response :success
  end

  test "should update servicio_realizado" do
    put :update, id: @servicio_realizado, servicio_realizado: { bonificacion: @servicio_realizado.bonificacion, descripcion: @servicio_realizado.descripcion, fecha: @servicio_realizado.fecha, monto: @servicio_realizado.monto }
    assert_redirected_to servicio_realizado_path(assigns(:servicio_realizado))
  end

  test "should destroy servicio_realizado" do
    assert_difference('ServicioRealizado.count', -1) do
      delete :destroy, id: @servicio_realizado
    end

    assert_redirected_to servicios_realizados_path
  end
end
