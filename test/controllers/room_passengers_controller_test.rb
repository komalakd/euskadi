require 'test_helper'

class RoomPassengersControllerTest < ActionController::TestCase
  setup do
    @room_passenger = room_passengers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:room_passengers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create room_passenger" do
    assert_difference('RoomPassenger.count') do
      post :create, room_passenger: { passenger_id: @room_passenger.passenger_id, reservation_room_id: @room_passenger.reservation_room_id }
    end

    assert_redirected_to room_passenger_path(assigns(:room_passenger))
  end

  test "should show room_passenger" do
    get :show, id: @room_passenger
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @room_passenger
    assert_response :success
  end

  test "should update room_passenger" do
    patch :update, id: @room_passenger, room_passenger: { passenger_id: @room_passenger.passenger_id, reservation_room_id: @room_passenger.reservation_room_id }
    assert_redirected_to room_passenger_path(assigns(:room_passenger))
  end

  test "should destroy room_passenger" do
    assert_difference('RoomPassenger.count', -1) do
      delete :destroy, id: @room_passenger
    end

    assert_redirected_to room_passengers_path
  end
end
