class EstadosTribAfipController < ApplicationController
  # GET /estados_trib_afip
  # GET /estados_trib_afip.json
  def index
    @estados_trib_afip = EstadoTribAfip.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @estados_trib_afip }
    end
  end

  # GET /estados_trib_afip/1
  # GET /estados_trib_afip/1.json
  def show
    @estado_trib_afip = EstadoTribAfip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @estado_trib_afip }
    end
  end

  # GET /estados_trib_afip/new
  # GET /estados_trib_afip/new.json
  def new
    @estado_trib_afip = EstadoTribAfip.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @estado_trib_afip }
    end
  end

  # GET /estados_trib_afip/1/edit
  def edit
    @estado_trib_afip = EstadoTribAfip.find(params[:id])
  end

  # POST /estados_trib_afip
  # POST /estados_trib_afip.json
  def create
    @estado_trib_afip = EstadoTribAfip.new(params[:estado_trib_afip])

    respond_to do |format|
      if @estado_trib_afip.save
        format.html { redirect_to @estado_trib_afip, notice: 'Estado trib afip was successfully created.' }
        format.json { render json: @estado_trib_afip, status: :created, location: @estado_trib_afip }
      else
        format.html { render action: "new" }
        format.json { render json: @estado_trib_afip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /estados_trib_afip/1
  # PUT /estados_trib_afip/1.json
  def update
    @estado_trib_afip = EstadoTribAfip.find(params[:id])

    respond_to do |format|
      if @estado_trib_afip.update_attributes(params[:estado_trib_afip])
        format.html { redirect_to @estado_trib_afip, notice: 'Estado trib afip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @estado_trib_afip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estados_trib_afip/1
  # DELETE /estados_trib_afip/1.json
  def destroy
    @estado_trib_afip = EstadoTribAfip.find(params[:id])
    @estado_trib_afip.destroy

    respond_to do |format|
      format.html { redirect_to estados_trib_afip_url }
      format.json { head :no_content }
    end
  end
end
