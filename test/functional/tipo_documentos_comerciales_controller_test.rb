require 'test_helper'

class TipoDocumentosComercialesControllerTest < ActionController::TestCase
  setup do
    @tipo_documento_comercial = tipo_documentos_comerciales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_documentos_comerciales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_documento_comercial" do
    assert_difference('TipoDocumentoComercial.count') do
      post :create, tipo_documento_comercial: { descripcion: @tipo_documento_comercial.descripcion, nombre: @tipo_documento_comercial.nombre }
    end

    assert_redirected_to tipo_documento_comercial_path(assigns(:tipo_documento_comercial))
  end

  test "should show tipo_documento_comercial" do
    get :show, id: @tipo_documento_comercial
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_documento_comercial
    assert_response :success
  end

  test "should update tipo_documento_comercial" do
    put :update, id: @tipo_documento_comercial, tipo_documento_comercial: { descripcion: @tipo_documento_comercial.descripcion, nombre: @tipo_documento_comercial.nombre }
    assert_redirected_to tipo_documento_comercial_path(assigns(:tipo_documento_comercial))
  end

  test "should destroy tipo_documento_comercial" do
    assert_difference('TipoDocumentoComercial.count', -1) do
      delete :destroy, id: @tipo_documento_comercial
    end

    assert_redirected_to tipo_documentos_comerciales_path
  end
end
