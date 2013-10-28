require 'test_helper'

class GroupRoomsControllerTest < ActionController::TestCase
  setup do
    @group_room = group_rooms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_rooms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_room" do
    assert_difference('GroupRoom.count') do
      post :create, group_room: { group_id: @group_room.group_id, room_id: @group_room.room_id }
    end

    assert_redirected_to group_room_path(assigns(:group_room))
  end

  test "should show group_room" do
    get :show, id: @group_room
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_room
    assert_response :success
  end

  test "should update group_room" do
    patch :update, id: @group_room, group_room: { group_id: @group_room.group_id, room_id: @group_room.room_id }
    assert_redirected_to group_room_path(assigns(:group_room))
  end

  test "should destroy group_room" do
    assert_difference('GroupRoom.count', -1) do
      delete :destroy, id: @group_room
    end

    assert_redirected_to group_rooms_path
  end
end
