require 'test_helper'

class ProvinciasControllerTest < ActionController::TestCase
  setup do
    @provincia = provincias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:provincias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create provincia" do
    assert_difference('Provincia.count') do
      post :create, provincia: { nombre: @provincia.nombre }
    end

    assert_redirected_to provincia_path(assigns(:provincia))
  end

  test "should show provincia" do
    get :show, id: @provincia
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @provincia
    assert_response :success
  end

  test "should update provincia" do
    put :update, id: @provincia, provincia: { nombre: @provincia.nombre }
    assert_redirected_to provincia_path(assigns(:provincia))
  end

  test "should destroy provincia" do
    assert_difference('Provincia.count', -1) do
      delete :destroy, id: @provincia
    end

    assert_redirected_to provincias_path
  end
end
