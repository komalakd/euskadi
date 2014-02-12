class ReservationRoomsController < ApplicationController

  before_filter :signed_in_user
  before_action :set_reservation_room, only: [:show, :edit, :update, :destroy]

  # GET /reservation_rooms
  # GET /reservation_rooms.json
  def index
    @reservation_rooms = ReservationRoom.all
  end

  # GET /reservation_rooms/1
  # GET /reservation_rooms/1.json
  def show
  end

  # GET /reservation_rooms/new
  def new
    @reservation_room = ReservationRoom.new
    @reservations = Reservation.all
  end

  # GET /reservation_rooms/1/edit
  def edit
    @reservations = Reservation.all
  end

  # POST /reservation_rooms
  # POST /reservation_rooms.json
  def create
    @reservation_room = ReservationRoom.new(reservation_room_params)
    @reservations = Reservation.all
    
    respond_to do |format|
      if @reservation_room.save
        format.html { redirect_to @reservation_room, notice: 'La habitacion se ha asignado a la reserva correctamente.' }
        format.json { render action: 'show', status: :created, location: @reservation_room }
      else
        format.html { render action: 'new' }
        format.json { render json: @reservation_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservation_rooms/1
  # PATCH/PUT /reservation_rooms/1.json
  def update
    respond_to do |format|
      if @reservation_room.update(reservation_room_params)
        format.html { redirect_to @reservation_room, notice: 'Los datos de la reserva de la habitacion se han modificado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reservation_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservation_rooms/1
  # DELETE /reservation_rooms/1.json
  def destroy
    @reservation_room.destroy
    respond_to do |format|
      format.html { redirect_to reservation_rooms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation_room
      begin
        @reservation_room = ReservationRoom.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        redirect_to action: 'index'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_room_params
      params.require(:reservation_room).permit(:reservation_id, :amount, :since, :until)
    end
end
