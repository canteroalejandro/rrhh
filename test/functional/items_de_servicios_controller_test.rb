require 'test_helper'

class ItemsDeServiciosControllerTest < ActionController::TestCase
  setup do
    @item_de_servicio = items_de_servicios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items_de_servicios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_de_servicio" do
    assert_difference('ItemDeServicio.count') do
      post :create, item_de_servicio: { monto_establecido: @item_de_servicio.monto_establecido }
    end

    assert_redirected_to item_de_servicio_path(assigns(:item_de_servicio))
  end

  test "should show item_de_servicio" do
    get :show, id: @item_de_servicio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_de_servicio
    assert_response :success
  end

  test "should update item_de_servicio" do
    put :update, id: @item_de_servicio, item_de_servicio: { monto_establecido: @item_de_servicio.monto_establecido }
    assert_redirected_to item_de_servicio_path(assigns(:item_de_servicio))
  end

  test "should destroy item_de_servicio" do
    assert_difference('ItemDeServicio.count', -1) do
      delete :destroy, id: @item_de_servicio
    end

    assert_redirected_to items_de_servicios_path
  end
end
