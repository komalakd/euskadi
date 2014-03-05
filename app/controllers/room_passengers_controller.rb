class RoomPassengersController < ApplicationController
  before_action :set_room_passenger, only: [:show, :edit, :update, :destroy]

  # GET /room_passengers
  # GET /room_passengers.json
  # def index
  #   @room_passengers = RoomPassenger.all
  # end

  # GET /room_passengers/1
  # GET /room_passengers/1.json
  # def show
  # end

  # GET /room_passengers/new
  def new
    @room_passenger = RoomPassenger.new
    @passengers = Passenger.all
  end

  # GET /room_passengers/1/edit
  # def edit
  # end

  # POST /room_passengers
  # POST /room_passengers.json
  def create
    @room_passenger = RoomPassenger.new(room_passenger_params)
    @passengers = Passenger.all

    respond_to do |format|
      if @room_passenger.save
        format.html { redirect_to @room_passenger.reservation_room.reservation, notice: 'Room passenger was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @room_passenger }
      else
        format.html { render action: 'new' }
        format.json { render json: @room_passenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /room_passengers/1
  # PATCH/PUT /room_passengers/1.json
  # def update
  #   respond_to do |format|
  #     if @room_passenger.update(room_passenger_params)
  #       format.html { redirect_to @room_passenger, notice: 'Room passenger was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @room_passenger.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /room_passengers/1
  # DELETE /room_passengers/1.json
  def destroy
    @room_passenger.destroy
    respond_to do |format|
      format.html { redirect_to room_passengers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_passenger
      @room_passenger = RoomPassenger.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_passenger_params
      params.require(:room_passenger).permit(:reservation_room_id, :passenger_id)
    end
end
