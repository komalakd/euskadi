class EnterprisesController < ApplicationController

  before_filter :signed_in_user
  before_action :set_enterprise, only: [:show, :edit, :update, :destroy]

  # GET /enterprises
  # GET /enterprises.json
  def index
    @enterprises = Enterprise.all
  end

  # GET /enterprises/1
  # GET /enterprises/1.json
  def show
  end

  # GET /enterprises/new
  def new
    @enterprise = Enterprise.new
  end

  # GET /enterprises/1/edit
  def edit
  end

  # POST /enterprises
  # POST /enterprises.json
  def create
    @enterprise = Enterprise.new(enterprise_params)

    respond_to do |format|
      if @enterprise.save
        format.html { redirect_to @enterprise, notice: 'La empresa se ha registrado correctamente.' }
        format.json { render json: @enterprise, status: :created, location: @enterprise }
      else
        format.html { render action: 'new' }
        format.json { render json: @enterprise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enterprises/1
  # PATCH/PUT /enterprises/1.json
  def update
    respond_to do |format|
      if @enterprise.update(enterprise_params)
        format.html { redirect_to @enterprise, notice: 'Los datos de la empresa se han modificado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @enterprise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enterprises/1
  # DELETE /enterprises/1.json
  # def destroy
  #   @enterprise.destroy
  #   respond_to do |format|
  #     format.html { redirect_to enterprises_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enterprise
      begin
        @enterprise = Enterprise.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        redirect_to action: 'index'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enterprise_params
      params.require(:enterprise).permit(:cuit, :name, :address)
    end

end
