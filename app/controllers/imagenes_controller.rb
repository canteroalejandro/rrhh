class ImagenesController < ApplicationController
  # GET /imagenes
  # GET /imagenes.json
  def index
    @imagenes = Imagen.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @imagenes }
    end
  end

  # GET /imagenes/1
  # GET /imagenes/1.json
  def show
    @imagen = Imagen.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @imagen }
    end
  end

  # GET /imagenes/new
  # GET /imagenes/new.json
  def new
    @imagen = Imagen.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @imagen }
    end
  end

  # GET /imagenes/1/edit
  def edit
    @imagen = Imagen.find(params[:id])
  end

  # POST /imagenes
  # POST /imagenes.json
  def create
    @imagen = Imagen.new(params[:imagen])

    respond_to do |format|
      if @imagen.save
        format.html { redirect_to @imagen, notice: 'Imagen was successfully created.' }
        format.json { render json: @imagen, status: :created, location: @imagen }
      else
        format.html { render action: "new" }
        format.json { render json: @imagen.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /imagenes/1
  # PUT /imagenes/1.json
  def update
    @imagen = Imagen.find(params[:id])

    respond_to do |format|
      if @imagen.update_attributes(params[:imagen])
        format.html { redirect_to @imagen, notice: 'Imagen was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @imagen.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imagenes/1
  # DELETE /imagenes/1.json
  def destroy
    @imagen = Imagen.find(params[:id])
    @imagen.destroy

    respond_to do |format|
      format.html { redirect_to imagenes_url }
      format.json { head :no_content }
    end
  end
end
