require 'test_helper'

class HoraExtrasControllerTest < ActionController::TestCase
  setup do
    @hora_extra = hora_extras(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hora_extras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hora_extra" do
    assert_difference('HoraExtra.count') do
      post :create, hora_extra: { codigo: @hora_extra.codigo, dia: @hora_extra.dia, horaFin: @hora_extra.horaFin, horaInicio: @hora_extra.horaInicio, nombre: @hora_extra.nombre, precio: @hora_extra.precio }
    end

    assert_redirected_to hora_extra_path(assigns(:hora_extra))
  end

  test "should show hora_extra" do
    get :show, id: @hora_extra
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hora_extra
    assert_response :success
  end

  test "should update hora_extra" do
    patch :update, id: @hora_extra, hora_extra: { codigo: @hora_extra.codigo, dia: @hora_extra.dia, horaFin: @hora_extra.horaFin, horaInicio: @hora_extra.horaInicio, nombre: @hora_extra.nombre, precio: @hora_extra.precio }
    assert_redirected_to hora_extra_path(assigns(:hora_extra))
  end

  test "should destroy hora_extra" do
    assert_difference('HoraExtra.count', -1) do
      delete :destroy, id: @hora_extra
    end

    assert_redirected_to hora_extras_path
  end
end
