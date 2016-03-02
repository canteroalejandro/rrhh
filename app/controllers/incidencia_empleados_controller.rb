class IncidenciaEmpleadosController < ApplicationController
  before_action :set_incidencia_empleado, only: [:show, :edit, :update, :destroy]

  # GET /incidencia_empleados
  # GET /incidencia_empleados.json
  def index
    @empleado = Empleado.find(params[:empleado_id])
    @incidencia_empleados = @empleado.incidencia_empleados.all
  end

  # GET /incidencia_empleados/1
  # GET /incidencia_empleados/1.json
  def show
  end

  # GET /incidencia_empleados/new
  def new
	  @empleado = Empleado.find(params[:empleado_id])
    @incidencia_empleado = @empleado.incidencia_empleados.new
  end

  # GET /incidencia_empleados/1/edit
  def edit
  end

  # POST /incidencia_empleados
  # POST /incidencia_empleados.json
  def create
    @empleado = Empleado.find(params[:empleado_id])
    @incidencia_empleado = @empleado.incidencia_empleados.new(incidencia_empleado_params)

    respond_to do |format|
      if @incidencia_empleado.save
        format.html { redirect_to [@incidencia_empleado.empleado, @incidencia_empleado], notice: 'Incidencia Empleado was successfully created.' }
        format.json { render :show, status: :created, location: @incidencia_empleado }
      else
        format.html { render :new }
        format.json { render json: @incidencia_empleado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidencia_empleados/1
  # PATCH/PUT /incidencia_empleados/1.json
  def update
    @empleado = Empleado.find(params[:empleado_id])
    @incidencia_empleado = @empleado.incidencia_empleados.find(params[:id])

    respond_to do |format|
      if @incidencia_empleado.update(incidencia_empleado_params)
        format.html { redirect_to [@incidencia_empleado.empleado, @incidencia_empleado], notice: 'Incidencia Empleado was successfully updated.' }
        format.json { render :show, status: :ok, location: @incidencia_empleado }
      else
        format.html { render :edit }
        format.json { render json: @incidencia_empleado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidencia_empleados/1
  # DELETE /incidencia_empleados/1.json
  def destroy
    @empleado = Empleado.find(params[:empleado_id])
    @incidencia_empleado = @empleado.incidencia_empleados.find(params[:id])
    @incidencia_empleado.destroy
    respond_to do |format|
      format.html { redirect_to empleado_incidencia_empleados_url, notice: 'Incidencia Empleado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incidencia_empleado
      @empleado = Empleado.find(params[:empleado_id])
      @incidencia_empleado = @empleado.incidencia_empleados.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incidencia_empleado_params
      params.require(:incidencia_empleado).permit(:empleado_id, :incidencia_id, :inicio, :fin)
    end
end
