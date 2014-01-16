require 'test_helper'

class RoomPagesControllerTest < ActionController::TestCase
  setup do
    @room_page = room_pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:room_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create room_page" do
    assert_difference('RoomPage.count') do
      post :create, room_page: { order: @room_page.order, page_id: @room_page.page_id }
    end

    assert_redirected_to room_page_path(assigns(:room_page))
  end

  test "should show room_page" do
    get :show, id: @room_page
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @room_page
    assert_response :success
  end

  test "should update room_page" do
    patch :update, id: @room_page, room_page: { order: @room_page.order, page_id: @room_page.page_id }
    assert_redirected_to room_page_path(assigns(:room_page))
  end

  test "should destroy room_page" do
    assert_difference('RoomPage.count', -1) do
      delete :destroy, id: @room_page
    end

    assert_redirected_to room_pages_path
  end
end
