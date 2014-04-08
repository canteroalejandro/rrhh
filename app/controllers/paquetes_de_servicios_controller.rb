class PaquetesDeServiciosController < ApplicationController
  # GET /paquetes_de_servicios
  # GET /paquetes_de_servicios.json
  def index
    @paquetes_de_servicios = PaqueteDeServicio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @paquetes_de_servicios }
    end
  end

  # GET /paquetes_de_servicios/1
  # GET /paquetes_de_servicios/1.json
  def show
    @paquete_de_servicio = PaqueteDeServicio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @paquete_de_servicio }
    end
  end

  # GET /paquetes_de_servicios/new
  # GET /paquetes_de_servicios/new.json
  def new
    @paquete_de_servicio = PaqueteDeServicio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paquete_de_servicio }
    end
  end

  # GET /paquetes_de_servicios/1/edit
  def edit
    @paquete_de_servicio = PaqueteDeServicio.find(params[:id])
  end

  # POST /paquetes_de_servicios
  # POST /paquetes_de_servicios.json
  def create
    @paquete_de_servicio = PaqueteDeServicio.new(params[:paquete_de_servicio])

    respond_to do |format|
      if @paquete_de_servicio.save
        format.html { redirect_to @paquete_de_servicio, notice: 'Paquete de servicio was successfully created.' }
        format.json { render json: @paquete_de_servicio, status: :created, location: @paquete_de_servicio }
      else
        format.html { render action: "new" }
        format.json { render json: @paquete_de_servicio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /paquetes_de_servicios/1
  # PUT /paquetes_de_servicios/1.json
  def update
    @paquete_de_servicio = PaqueteDeServicio.find(params[:id])

    respond_to do |format|
      if @paquete_de_servicio.update_attributes(params[:paquete_de_servicio])
        format.html { redirect_to @paquete_de_servicio, notice: 'Paquete de servicio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @paquete_de_servicio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paquetes_de_servicios/1
  # DELETE /paquetes_de_servicios/1.json
  def destroy
    @paquete_de_servicio = PaqueteDeServicio.find(params[:id])
    @paquete_de_servicio.destroy

    respond_to do |format|
      format.html { redirect_to paquetes_de_servicios_url }
      format.json { head :no_content }
    end
  end
end
