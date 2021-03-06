class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_filter :signed_in_user
  
  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
    @rooms = Room.all

    since_date = date_param || Date.today - 3
    until_date = since_date + 14
    @dates = ( since_date )..( until_date )

    @reservation_rooms = ReservationRoom.where( "since <= ? OR until >= ?", until_date, since_date )
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @passenger = Passenger.new
    @passengers = Passenger.all
    if !(@passengers.size > 0)
      respond_to do |format|
        format.html { redirect_to reservations_path, alert: 'Para registrar una nueva reserva debe cargar al menos un pasajero.' }
      end
    end
    @reservation = Reservation.new
    @enterprises = Enterprise.all.order(:name)
    @enterprise = Enterprise.new
    @rooms = Room.all.order(:id)
    @room_types = RoomType.all
    @groups = Group.all
  end

  # GET /reservations/1/edit
  def edit
    @passenger = Passenger.new
    @enterprise = Enterprise.new
    @passengers = Passenger.all
    @enterprises = Enterprise.all.order(:name)
    @rooms = Room.all
    @room_types = RoomType.all
    @groups = Group.all
  end

  # POST /reservations
  # POST /reservations.json
  def create

    @reservation = Reservation.new(reservation_params)

    @passenger = Passenger.new
    @passengers = Passenger.all
    @enterprise = Enterprise.new
    @enterprises = Enterprise.all
    @rooms = Room.all
    @groups = Group.all
    @room_types = RoomType.all

    respond_to do |format|
      if @reservation.guardar( new_reservation_rooms )
        format.html { redirect_to @reservation, notice: 'La reserva se ha registrado correctamente.' }
        format.json { render action: 'show', status: :created, location: @reservation }
      else
        format.html { render action: 'new' }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update

    @rooms = Room.all
    @groups = Group.all
    @passenger = Passenger.new
    @passengers = Passenger.all
    @enterprise = Enterprise.new
    @enterprises = Enterprise.all
    @room_types = RoomType.all

    @reservation.update_attributes( reservation_params )

    respond_to do |format|
      if @reservation.guardar( new_reservation_rooms )
        format.html { redirect_to @reservation, notice: 'Los datos de la reserva ha sido modificados correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      begin
        @reservation = Reservation.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        redirect_to action: 'index'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:passenger_id, :enterprise_id, :amount, :observation)
    end

    def reservation_room_params
      room_checkboxes = params.require(:chk_reservation_room) if params[:chk_reservation_room]
      return {} unless room_checkboxes
      params.require(:reservation_room).slice( *room_checkboxes.keys )
    end

    def reservation_group_params
      group_checkboxes = params.require(:chk_reservation_group) if params[:chk_reservation_group]
      return {} unless group_checkboxes
      params.require(:reservation_group).slice( *group_checkboxes.keys )
    end

    def new_reservation_rooms
      
      new_reservation_rooms = []
      reservation_room_params.keys.each do |room_id|
        new_reservation_rooms << ReservationRoom.new(
          amount: reservation_room_params[room_id]["amount"],
          since: Date.strptime(reservation_room_params[room_id]["since"],"%d/%m/%Y"),
          until: Date.strptime(reservation_room_params[room_id]["until"],"%d/%m/%Y"),
          reservation_item: Room.find(room_id)
        )
      end

      new_reservation_groups = []
      reservation_group_params.keys.each do |group_id|
        new_reservation_groups << ReservationRoom.new(
          amount: reservation_group_params[group_id]["amount"],
          since: Date.strptime(reservation_group_params[group_id]["since"],"%d/%m/%Y"),
          until: Date.strptime(reservation_group_params[group_id]["until"],"%d/%m/%Y"),
          reservation_item: Group.find(group_id)
        )
      end

      return { rooms: new_reservation_rooms, groups: new_reservation_groups }

    end

    def date_param
      return params[:date] ? Date.strptime( params[:date], "%d/%m/%Y" ) : nil
    end

end
