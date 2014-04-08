class ServiciosRealizadosController < ApplicationController
  # GET /servicios_realizados
  # GET /servicios_realizados.json
  def index
    @servicios_realizados = ServicioRealizado.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @servicios_realizados }
    end
  end

  # GET /servicios_realizados/1
  # GET /servicios_realizados/1.json
  def show
    @servicio_realizado = ServicioRealizado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @servicio_realizado }
    end
  end

  # GET /servicios_realizados/new
  # GET /servicios_realizados/new.json
  def new
    @servicio_realizado = ServicioRealizado.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @servicio_realizado }
    end
  end

  # GET /servicios_realizados/1/edit
  def edit
    @servicio_realizado = ServicioRealizado.find(params[:id])
  end

  # POST /servicios_realizados
  # POST /servicios_realizados.json
  def create
    @servicio_realizado = ServicioRealizado.new(params[:servicio_realizado])

    respond_to do |format|
      if @servicio_realizado.save
        format.html { redirect_to @servicio_realizado, notice: 'Servicio realizado was successfully created.' }
        format.json { render json: @servicio_realizado, status: :created, location: @servicio_realizado }
      else
        format.html { render action: "new" }
        format.json { render json: @servicio_realizado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /servicios_realizados/1
  # PUT /servicios_realizados/1.json
  def update
    @servicio_realizado = ServicioRealizado.find(params[:id])

    respond_to do |format|
      if @servicio_realizado.update_attributes(params[:servicio_realizado])
        format.html { redirect_to @servicio_realizado, notice: 'Servicio realizado was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @servicio_realizado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servicios_realizados/1
  # DELETE /servicios_realizados/1.json
  def destroy
    @servicio_realizado = ServicioRealizado.find(params[:id])
    @servicio_realizado.destroy

    respond_to do |format|
      format.html { redirect_to servicios_realizados_url }
      format.json { head :no_content }
    end
  end
end
