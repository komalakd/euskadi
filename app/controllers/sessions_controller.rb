class SessionsController < ApplicationController
  # before_action :set_session, only: [:show, :edit, :update, :destroy]

  # GET /sessions
  # GET /sessions.json
  # def index
  #   @sessions = Session.all
  # end

  # GET /sessions/1
  # GET /sessions/1.json
  # def show
  # end

  # GET /sessions/new
  def new
    @session = Session.new
  end

  # GET /sessions/1/edit
  # def edit
  # end

  # POST /sessions
  # POST /sessions.json
  def create
  user = User.find_by_email(params[:email].downcase)
  if user #&& user.authenticate(params[:password])
    # Sign the user in and redirect to the user's show page.
    sign_in user, permanent: params[:remember_me]
    redirect_back_or root_url
  else
    # Create an error message and re-render the signin form.
    @error = 'Los datos ingresados no son validos.'
    render 'new'
  end
end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  # def update
  #   respond_to do |format|
  #     if @session.update(session_params)
  #       format.html { redirect_to @session, notice: 'Session was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @session.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    sign_out
    redirect_to root_url
  end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_session
  #     @session = Session.find(params[:id])
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def session_params
  #     params[:session]
  #   end
end
