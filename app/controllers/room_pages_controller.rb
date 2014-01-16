class RoomPagesController < ApplicationController
  before_action :set_room_page, only: [:show, :edit, :update, :destroy]

  # GET /room_pages
  # GET /room_pages.json
  def index
    @room_pages = RoomPage.all
  end

  # GET /room_pages/1
  # GET /room_pages/1.json
  def show
  end

  # GET /room_pages/new
  def new
    @room_page = RoomPage.new
  end

  # GET /room_pages/1/edit
  def edit
  end

  # POST /room_pages
  # POST /room_pages.json
  def create
    @room_page = RoomPage.new(room_page_params)

    respond_to do |format|
      if @room_page.save
        format.html { redirect_to @room_page, notice: 'Room page was successfully created.' }
        format.json { render action: 'show', status: :created, location: @room_page }
      else
        format.html { render action: 'new' }
        format.json { render json: @room_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /room_pages/1
  # PATCH/PUT /room_pages/1.json
  def update
    respond_to do |format|
      if @room_page.update(room_page_params)
        format.html { redirect_to @room_page, notice: 'Room page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @room_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /room_pages/1
  # DELETE /room_pages/1.json
  def destroy
    @room_page.destroy
    respond_to do |format|
      format.html { redirect_to room_pages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_page
      @room_page = RoomPage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_page_params
      params.require(:room_page).permit(:page_id, :order)
    end
end
