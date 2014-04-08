require 'test_helper'

class ContadoresControllerTest < ActionController::TestCase
  setup do
    @contador = contadores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contadores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contador" do
    assert_difference('Contador.count') do
      post :create, contador: { nombre: @contador.nombre }
    end

    assert_redirected_to contador_path(assigns(:contador))
  end

  test "should show contador" do
    get :show, id: @contador
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contador
    assert_response :success
  end

  test "should update contador" do
    put :update, id: @contador, contador: { nombre: @contador.nombre }
    assert_redirected_to contador_path(assigns(:contador))
  end

  test "should destroy contador" do
    assert_difference('Contador.count', -1) do
      delete :destroy, id: @contador
    end

    assert_redirected_to contadores_path
  end
end
