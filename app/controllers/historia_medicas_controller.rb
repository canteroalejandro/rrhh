class HistoriaMedicasController < ApplicationController
  before_action :set_historia_medica, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /historia_medicas
  # GET /historia_medicas.json
  def index
    @empleado = Empleado.find(params[:empleado_id])
    @historia_medicas = @empleado.historia_medicas.all
  end

  # GET /historia_medicas/1
  # GET /historia_medicas/1.json
  def show
  end

  # GET /historia_medicas/new
  def new
	  @empleado = Empleado.find(params[:empleado_id])
    @historia_medica = @empleado.historia_medicas.new
  end

  # GET /historia_medicas/1/edit
  def edit
  end

  # POST /historia_medicas
  # POST /historia_medicas.json
  def create
    @empleado = Empleado.find(params[:empleado_id])
    @historia_medica = @empleado.historia_medicas.new(historia_medica_params)

    respond_to do |format|
      if @historia_medica.save
        format.html { redirect_to [@historia_medica.empleado, @historia_medica], notice: 'Historia Médica was successfully created.' }
        format.json { render :show, status: :created, location: @historia_medica }
      else
        format.html { render :new }
        format.json { render json: @historia_medica.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /historia_medicas/1
  # PATCH/PUT /historia_medicas/1.json
  def update
    @empleado = Empleado.find(params[:empleado_id])
    @historia_medica = @empleado.historia_medicas.find(params[:id])

    respond_to do |format|
      if @historia_medica.update(historia_medica_params)
        format.html { redirect_to [@historia_medica.empleado, @historia_medica], notice: 'Historia Médica was successfully updated.' }
        format.json { render :show, status: :ok, location: @historia_medica }
      else
        format.html { render :edit }
        format.json { render json: @historia_medica.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /historia_medicas/1
  # DELETE /historia_medicas/1.json
  def destroy
    @empleado = Empleado.find(params[:empleado_id])
    @historia_medica = @empleado.historia_medicas.find(params[:id])
    @historia_medica.destroy
    respond_to do |format|
      format.html { redirect_to empleado_historia_medicas_url, notice: 'Historia Médica was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_historia_medica
      @empleado = Empleado.find(params[:empleado_id])
      @historia_medica = @empleado.historia_medicas.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def historia_medica_params
      params.require(:historia_medica).permit(:codigo, :fecha, :doctor, :empleado_id)
    end
end
