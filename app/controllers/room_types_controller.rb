class RoomTypesController < ApplicationController

  before_filter :signed_in_user
  before_action :set_room_type, only: [:show, :edit, :update, :destroy]

  # GET /room_types
  # GET /room_types.json
  def index
    @room_types = RoomType.all
  end

  # GET /room_types/1
  # GET /room_types/1.json
  def show
  end

  # GET /room_types/new
  # def new
  #   @room_type = RoomType.new
  # end

  # GET /room_types/1/edit
  def edit
  end

  # POST /room_types
  # POST /room_types.json
  # def create
  #   @room_type = RoomType.new(room_type_params)

  #   respond_to do |format|
  #     if @room_type.save
  #       format.html { redirect_to @room_type, notice: 'El tipo de habitacion se ha registrado correctamente.' }
  #       format.json { render action: 'show', status: :created, location: @room_type }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @room_type.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /room_types/1
  # PATCH/PUT /room_types/1.json
  def update
    respond_to do |format|
      if @room_type.update(room_type_params)
        format.html { redirect_to @room_type, notice: 'Los datos del tipo de habitacion se han registrado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @room_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /room_types/1
  # DELETE /room_types/1.json
  # def destroy
  #   @room_type.destroy
  #   respond_to do |format|
  #     format.html { redirect_to room_types_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_type
      begin
        @room_type = RoomType.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        redirect_to action: 'index'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_type_params
      params.require(:room_type).permit(:denomination, :amount)
    end
end
