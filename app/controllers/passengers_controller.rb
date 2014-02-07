class PassengersController < ApplicationController
  # GET /passengers
  # GET /passengers.json
  def index
    @passengers = Passenger.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @passengers }
    end
  end

  # GET /passengers/1
  # GET /passengers/1.json
  def show
    @passenger = Passenger.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @passenger }
    end
  end

  # GET /passengers/new
  # GET /passengers/new.json
  def new
    @passenger = Passenger.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @passenger }
    end
  end

  # GET /passengers/1/edit
  def edit
    @passenger = Passenger.find(params[:id])
  end

  # POST /passengers
  # POST /passengers.json
  def create
    @passenger = Passenger.new(passenger_params)

    respond_to do |format|
      if @passenger.save
        format.html { redirect_to @passenger, notice: 'El pasajero se ha registrado correctamente.' }
        format.json { render json: @passenger, status: :created, location: @passenger }
      else
        format.html { render action: "new" }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /passengers/1
  # PUT /passengers/1.json
  def update
    @passenger = Passenger.find(params[:id])

    respond_to do |format|
      if @passenger.update_attributes(passenger_params)
        format.html { redirect_to @passenger, notice: 'Los datos del pasajero se ha modificado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @passenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /passengers/1
  # DELETE /passengers/1.json
  # def destroy
  #   @passenger = Passenger.find(params[:id])
  #   @passenger.destroy

  #   respond_to do |format|
  #     format.html { redirect_to passengers_url }
  #     format.json { head :no_content }
  #   end
  # end

  private

    def passenger_params
      params.require(:passenger).permit(:address, :birthdate, :city, :civil_status, :country, :dni, :lastname, :name, :nationality, :proffesion, :phone_number, :province)
    end
  
end
