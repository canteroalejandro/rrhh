class ContratoEmpleadosController < ApplicationController
  before_action :set_contrato_empleado, only: [:show, :edit, :update, :destroy]

  # GET /contrato_empleados
  # GET /contrato_empleados.json
  def index
    @empleado = Empleado.find(params[:empleado_id])
    @contrato_empleados = @empleado.contrato_empleados.all
  end

  # GET /contrato_empleados/1
  # GET /contrato_empleados/1.json
  def show
  end

  # GET /contrato_empleados/new
  def new
    @empleado = Empleado.find(params[:empleado_id])
    @vinculo_anterior = @empleado.contrato_empleados.last
    @contrato_empleado = @empleado.contrato_empleados.new
  end

  # GET /contrato_empleados/1/edit
  def edit
  end

  # POST /contrato_empleados
  # POST /contrato_empleados.json
  def create
    @empleado = Empleado.find(params[:empleado_id])
    @contrato_empleado = @empleado.contrato_empleados.new(contrato_empleado_params)

    respond_to do |format|
      if @contrato_empleado.save
        format.html { redirect_to [@contrato_empleado.empleado, @contrato_empleado], notice: 'Contrato Empleado was successfully created.' }
        format.json { render :show, status: :created, location: @contrato_empleado }
      else
        format.html { render :new }
        format.json { render json: @contrato_empleado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contrato_empleados/1
  # PATCH/PUT /contrato_empleados/1.json
  def update
    @empleado = Empleado.find(params[:empleado_id])
    @contrato_empleado = @empleado.contrato_empleados.find(params[:id])

    respond_to do |format|
      if @contrato_empleado.update(contrato_empleado_params)
        format.html { redirect_to [@contrato_empleado.empleado, @contrato_empleado], notice: 'Contrato Empleado was successfully updated.' }
        format.json { render :show, status: :ok, location: @contrato_empleado }
      else
        format.html { render :edit }
        format.json { render json: @contrato_empleado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contrato_empleados/1
  # DELETE /contrato_empleados/1.json
  def destroy
    @empleado = Empleado.find(params[:empleado_id])
    @contrato_empleado = @empleado.contrato_empleados.find(params[:id])
    @contrato_empleado.destroy
    respond_to do |format|
      format.html { redirect_to empleado_contrato_empleados_url, notice: 'Contrato Empleado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contrato_empleado
      @empleado = Empleado.find(params[:empleado_id])
      @contrato_empleado = @empleado.contrato_empleados.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contrato_empleado_params
      params.require(:contrato_empleado).permit(:empleado_id, :contrato_id, :inicio, :fin)
    end
end
