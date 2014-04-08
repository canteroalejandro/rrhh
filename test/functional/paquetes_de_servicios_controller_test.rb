require 'test_helper'

class PaquetesDeServiciosControllerTest < ActionController::TestCase
  setup do
    @paquete_de_servicio = paquetes_de_servicios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paquetes_de_servicios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paquete_de_servicio" do
    assert_difference('PaqueteDeServicio.count') do
      post :create, paquete_de_servicio: { activo: @paquete_de_servicio.activo, descripcion: @paquete_de_servicio.descripcion, monto: @paquete_de_servicio.monto }
    end

    assert_redirected_to paquete_de_servicio_path(assigns(:paquete_de_servicio))
  end

  test "should show paquete_de_servicio" do
    get :show, id: @paquete_de_servicio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @paquete_de_servicio
    assert_response :success
  end

  test "should update paquete_de_servicio" do
    put :update, id: @paquete_de_servicio, paquete_de_servicio: { activo: @paquete_de_servicio.activo, descripcion: @paquete_de_servicio.descripcion, monto: @paquete_de_servicio.monto }
    assert_redirected_to paquete_de_servicio_path(assigns(:paquete_de_servicio))
  end

  test "should destroy paquete_de_servicio" do
    assert_difference('PaqueteDeServicio.count', -1) do
      delete :destroy, id: @paquete_de_servicio
    end

    assert_redirected_to paquetes_de_servicios_path
  end
end
