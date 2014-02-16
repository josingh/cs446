require 'test_helper'

class AnimalItemsControllerTest < ActionController::TestCase
  setup do
    @animal_item = animal_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:animal_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create animal_item" do
    assert_difference('AnimalItem.count') do
     post :create, animal_id: animals(:ruby).id
    end

    assert_redirected_to checkout_path(assigns(:animal_item).checkout)
  end

  test "should show animal_item" do
    get :show, id: @animal_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @animal_item
    assert_response :success
  end

  test "should update animal_item" do
    patch :update, id: @animal_item, animal_item: { animal_id: @animal_item.animal_id, checkout_id: @animal_item.checkout_id }
    assert_redirected_to animal_item_path(assigns(:animal_item))
  end

  test "should destroy animal_item" do
    assert_difference('AnimalItem.count', -1) do
      delete :destroy, id: @animal_item
    end

    assert_redirected_to animal_items_path
  end
end
