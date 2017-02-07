class HorariosController < ApplicationController
  before_action :set_empleado, only: [:show, :edit, :update, :destroy]
  before_action :set_horario, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET empleados/empleado_id/horarios
  # GET /horarios.json
  def index
    @horarios = Horario.all
  end

  # GET /horarios/1
  # GET /horarios/1.json
  def show
  end

  # GET empleados/empleado_id/horarios/new
  def new
    @empleado = Empleado.find params[:empleado_id] 
    @horario.detalle_horarios.build
  end


  def new_from
    @empleado = Empleado.find params[:empleado_id] 
    @horario = Horario.find(params[:horario_id])
  end

  # GET /horarios/1/edit
  def edit
  end

  def create_from
    @empleado = Empleado.find params[:empleado_id]
    @horario = Horario.new(horario_params)

    respond_to do |format|
      if @horario.save
        format.html { redirect_to @empleado, notice: 'Horario fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @horario }
      else
        format.html { render :new }
        format.json { render json: @horario.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /horarios
  # POST /horarios.json
  def create
    @empleado = Empleado.find params[:empleado_id]
    @horario = Horario.new(horario_params)

    respond_to do |format|
      if @horario.save
        format.html { redirect_to [@empleado, @horario], notice: 'Horario fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @horario }
      else
        format.html { render :new }
        format.json { render json: @horario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /horarios/1
  # PATCH/PUT /horarios/1.json
  def update
    respond_to do |format|
      # @horario.detalle_horarios.each { |e| e.destroy }

      if @horario.update(horario_params)
        format.html { redirect_to @horario, notice: 'Horario fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @horario }
      else
        format.html { render :edit }
        format.json { render json: @horario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /horarios/1
  # DELETE /horarios/1.json
  def destroy
    @horario.destroy
    respond_to do |format|
      format.html { redirect_to horarios_url, notice: 'Horario fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empleado
      @empleado = Empleado.find params[:empleado_id]
    end

    def set_horario
      @horario = Horario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horario_params
      params.require(:horario)
      .permit(:codigo, 
        :margenEntradaCheck, 
        :margenSalidaCheck, 
        :inicioMargenEntrada, 
        :finMargenEntrada, 
        :inicioMargenSalida, 
        :finMargenSalida, 
        :empleado_id, 
        detalle_horarios_attributes: [ 
          :dia, 
          :horaEntrada, 
          :horaSalida,
          :proyecto_id
        ])
    end
end
