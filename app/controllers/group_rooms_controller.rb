class GroupRoomsController < ApplicationController
  before_action :set_group_room, only: [:show, :edit, :update, :destroy]

  # GET /group_rooms
  # GET /group_rooms.json
  def index
    @group_rooms = GroupRoom.all
  end

  # GET /group_rooms/1
  # GET /group_rooms/1.json
  def show
  end

  # GET /group_rooms/new
  def new
    @group_room = GroupRoom.new
  end

  # GET /group_rooms/1/edit
  def edit
  end

  # POST /group_rooms
  # POST /group_rooms.json
  def create
    @group_room = GroupRoom.new(group_room_params)

    respond_to do |format|
      if @group_room.save
        format.html { redirect_to @group_room, notice: 'Group room was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group_room }
      else
        format.html { render action: 'new' }
        format.json { render json: @group_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_rooms/1
  # PATCH/PUT /group_rooms/1.json
  def update
    respond_to do |format|
      if @group_room.update(group_room_params)
        format.html { redirect_to @group_room, notice: 'Group room was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_rooms/1
  # DELETE /group_rooms/1.json
  def destroy
    @group_room.destroy
    respond_to do |format|
      format.html { redirect_to group_rooms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_room
      @group_room = GroupRoom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_room_params
      params.require(:group_room).permit(:room_id, :group_id)
    end
end
