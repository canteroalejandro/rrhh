require 'test_helper'

class IncidenciasControllerTest < ActionController::TestCase
  setup do
    @incidencia = incidencias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incidencias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create incidencia" do
    assert_difference('Incidencia.count') do
      post :create, incidencia: { codigo: @incidencia.codigo, fechaFinHabilitacion: @incidencia.fechaFinHabilitacion, fechaInicioHabilitacion: @incidencia.fechaInicioHabilitacion, nombre: @incidencia.nombre, nroAntiguedadMayor: @incidencia.nroAntiguedadMayor, nroAntiguedadMenor: @incidencia.nroAntiguedadMenor, nroDuracion: @incidencia.nroDuracion, tiempoAntiguedadMayor: @incidencia.tiempoAntiguedadMayor, tiempoAntiguedadMenor: @incidencia.tiempoAntiguedadMenor, tiempoDuracion: @incidencia.tiempoDuracion, tieneCondiciones: @incidencia.tieneCondiciones, vecesPermitidasPorAño: @incidencia.vecesPermitidasPorAño }
    end

    assert_redirected_to incidencia_path(assigns(:incidencia))
  end

  test "should show incidencia" do
    get :show, id: @incidencia
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @incidencia
    assert_response :success
  end

  test "should update incidencia" do
    patch :update, id: @incidencia, incidencia: { codigo: @incidencia.codigo, fechaFinHabilitacion: @incidencia.fechaFinHabilitacion, fechaInicioHabilitacion: @incidencia.fechaInicioHabilitacion, nombre: @incidencia.nombre, nroAntiguedadMayor: @incidencia.nroAntiguedadMayor, nroAntiguedadMenor: @incidencia.nroAntiguedadMenor, nroDuracion: @incidencia.nroDuracion, tiempoAntiguedadMayor: @incidencia.tiempoAntiguedadMayor, tiempoAntiguedadMenor: @incidencia.tiempoAntiguedadMenor, tiempoDuracion: @incidencia.tiempoDuracion, tieneCondiciones: @incidencia.tieneCondiciones, vecesPermitidasPorAño: @incidencia.vecesPermitidasPorAño }
    assert_redirected_to incidencia_path(assigns(:incidencia))
  end

  test "should destroy incidencia" do
    assert_difference('Incidencia.count', -1) do
      delete :destroy, id: @incidencia
    end

    assert_redirected_to incidencias_path
  end
end
