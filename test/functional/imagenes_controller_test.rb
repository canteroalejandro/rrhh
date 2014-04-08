require 'test_helper'

class ImagenesControllerTest < ActionController::TestCase
  setup do
    @imagen = imagenes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:imagenes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create imagen" do
    assert_difference('Imagen.count') do
      post :create, imagen: { fecha: @imagen.fecha, nombre: @imagen.nombre, url_imagen: @imagen.url_imagen }
    end

    assert_redirected_to imagen_path(assigns(:imagen))
  end

  test "should show imagen" do
    get :show, id: @imagen
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @imagen
    assert_response :success
  end

  test "should update imagen" do
    put :update, id: @imagen, imagen: { fecha: @imagen.fecha, nombre: @imagen.nombre, url_imagen: @imagen.url_imagen }
    assert_redirected_to imagen_path(assigns(:imagen))
  end

  test "should destroy imagen" do
    assert_difference('Imagen.count', -1) do
      delete :destroy, id: @imagen
    end

    assert_redirected_to imagenes_path
  end
end
