class AsistenciasController < ApplicationController
  before_action :set_asistencia, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /asistencias
  # GET /asistencias.json
  def index
    @empleado = Empleado.find(params[:empleado_id])
    @asistencias = @empleado.asistencias.all
  end

  # GET /asistencias/1
  # GET /asistencias/1.json
  def show
  end

  # GET /asistencias/new
  def new
	  @empleado = Empleado.find(params[:empleado_id])
    @asistencia = @empleado.asistencias.new
  end

  # GET /asistencias/1/edit
  def edit
  end

  # POST /asistencias
  # POST /asistencias.json
  def create
    @empleado = Empleado.find(params[:empleado_id])
    @asistencia = @empleado.asistencias.new(asistencia_params)

    respond_to do |format|
      if @asistencia.save
        format.html { redirect_to [@asistencia.empleado, @asistencia], notice: 'Asistencia was successfully created.' }
        format.json { render :show, status: :created, location: @asistencia }
      else
        format.html { render :new }
        format.json { render json: @asistencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asistencias/1
  # PATCH/PUT /asistencias/1.json
  def update
    @empleado = Empleado.find(params[:empleado_id])
    @asistencia = @empleado.asistencias.find(params[:id])

    respond_to do |format|
      if @asistencia.update(asistencia_params)
        format.html { redirect_to [@asistencia.empleado, @asistencia], notice: 'Asistencia was successfully updated.' }
        format.json { render :show, status: :ok, location: @asistencia }
      else
        format.html { render :edit }
        format.json { render json: @asistencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asistencias/1
  # DELETE /asistencias/1.json
  def destroy
    @empleado = Empleado.find(params[:empleado_id])
    @asistencia = @empleado.asistencias.find(params[:id])
    @asistencia.destroy
    respond_to do |format|
      format.html { redirect_to empleado_asistencias_url, notice: 'Asistencia was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Filtros AJAX

  def show_por_mes
    @empleado = Empleado.find params[:empleado_id]
    render "show_por_mes.html"
  end

  def ajax_table_por_mes
    @empleado = Empleado.find(params[:empleado_id])
    fecha = params[:fecha].to_date
    @asistencias = []
    @total_horas = 0
    if params[:proyecto][:id] != "all"
      @proyecto = Proyecto.find params[:proyecto][:id]
      @asistencias = @empleado.asistencias_by_mes_and_project fecha, @proyecto
    else
      @asistencias = @empleado.asistencias_by_mes_and_project fecha, "all"
    end
    horas = @asistencias.map { |a| a.calcular_horas_trabajadas } 
    @total_horas = horas.reduce(:+)
    render :partial => "table_por_mes.html", :locals => { asistencias: @asistencias }
  end

  def show_por_horas_extras
    @empleado = Empleado.find params[:empleado_id]
    render "show_por_horas_extras.html"
  end

  def ajax_table_por_horas_extras
    @empleado = Empleado.find(params[:empleado_id])
    fecha = params[:fecha].to_date
    @asistencias = []
    @total_horas = 0

    @hora_extra = HoraExtra.find params[:hora_extra][:id]
    @asistencias = @empleado.asistencias_by_mes_and_project fecha, @proyecto

    horas = @asistencias.map { |a| a.calcular_horas_trabajadas } 
    @total_horas = horas.reduce(:+)
    render :partial => "table_por_mes.html", :locals => { asistencias: @asistencias }
  end

  def table_por_tipo_hora_extra
    @movil = Movil.find(params[:id])
    @partidas = @movil.partidas.limit(1).order('id desc')
    render :partial => "entregas/ajax_table_hojas_de_rutas", :locals => { partidas: @partidas }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asistencia
      @empleado = Empleado.find(params[:empleado_id])
      @asistencia = @empleado.asistencias.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asistencia_params
      params.require(:asistencia).permit(:entrada, :salida, :outputAsistencia, :horasTrabajadas, :empleado_id, :check_in_id, :check_out_id)
    end
end
