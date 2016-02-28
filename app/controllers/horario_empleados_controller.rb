class HorarioEmpleadosController < ApplicationController
  before_action :set_horario_empleado, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /horario_empleados
  # GET /horario_empleados.json
  def index
    @horario_empleados = HorarioEmpleado.all
  end

  # GET /horario_empleados/1
  # GET /horario_empleados/1.json
  def show
  end

  # GET /horario_empleados/new
  def new
    #@episode = Episode.find(params[:subscription][:episode_id])
    @empleado = Empleado.find(params[:horario_empleado][:empleado_id])
    #@horario_empleado = @empleado.horario_empleado.new
    @horario_empleado = HorarioEmpleado.new(params[:empleado_id])
    @horario_empleado.empleado_id = @empleado.id

  end

  # GET /horario_empleados/1/edit
  def edit
  end

  # POST /horario_empleados
  # POST /horario_empleados.json
  def create

    @horario_empleado = HorarioEmpleado.new(horario_empleado_params)
    @horario_empleado.empleado_id = params[:horario_empleado][:empleado_id]
    
    #redirect_to([@diagnostico.consultum, @diagnostico]

    respond_to do |format|
      if @horario_empleado.save
        format.html { redirect_to request.referrer, notice: 'Horario empleado was successfully created.' }
        #format.json { render :show, status: :created, location: @horario_empleado }
      else
        format.html { render :new }
        #format.json { render json: @horario_empleado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /horario_empleados/1
  # PATCH/PUT /horario_empleados/1.json
  def update
    respond_to do |format|
      if @horario_empleado.update(horario_empleado_params)
        format.html { redirect_to @horario_empleado, notice: 'Horario empleado was successfully updated.' }
        format.json { render :show, status: :ok, location: @horario_empleado }
      else
        format.html { render :edit }
        format.json { render json: @horario_empleado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /horario_empleados/1
  # DELETE /horario_empleados/1.json
  def destroy
    @horario_empleado.destroy
    respond_to do |format|
      format.html { redirect_to horario_empleados_url, notice: 'Horario empleado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horario_empleado
      @horario_empleado = HorarioEmpleado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horario_empleado_params
      params.require(:horario_empleado).permit(:fechaInicio, :horario_id, :empleado_id)
    end
end
