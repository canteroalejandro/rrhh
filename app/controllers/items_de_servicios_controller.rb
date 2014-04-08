class ItemsDeServiciosController < ApplicationController
  # GET /items_de_servicios
  # GET /items_de_servicios.json
  def index
    @items_de_servicios = ItemDeServicio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items_de_servicios }
    end
  end

  # GET /items_de_servicios/1
  # GET /items_de_servicios/1.json
  def show
    @item_de_servicio = ItemDeServicio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item_de_servicio }
    end
  end

  # GET /items_de_servicios/new
  # GET /items_de_servicios/new.json
  def new
    @item_de_servicio = ItemDeServicio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item_de_servicio }
    end
  end

  # GET /items_de_servicios/1/edit
  def edit
    @item_de_servicio = ItemDeServicio.find(params[:id])
  end

  # POST /items_de_servicios
  # POST /items_de_servicios.json
  def create
    @item_de_servicio = ItemDeServicio.new(params[:item_de_servicio])

    respond_to do |format|
      if @item_de_servicio.save
        format.html { redirect_to @item_de_servicio, notice: 'Item de servicio was successfully created.' }
        format.json { render json: @item_de_servicio, status: :created, location: @item_de_servicio }
      else
        format.html { render action: "new" }
        format.json { render json: @item_de_servicio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items_de_servicios/1
  # PUT /items_de_servicios/1.json
  def update
    @item_de_servicio = ItemDeServicio.find(params[:id])

    respond_to do |format|
      if @item_de_servicio.update_attributes(params[:item_de_servicio])
        format.html { redirect_to @item_de_servicio, notice: 'Item de servicio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item_de_servicio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items_de_servicios/1
  # DELETE /items_de_servicios/1.json
  def destroy
    @item_de_servicio = ItemDeServicio.find(params[:id])
    @item_de_servicio.destroy

    respond_to do |format|
      format.html { redirect_to items_de_servicios_url }
      format.json { head :no_content }
    end
  end
end
