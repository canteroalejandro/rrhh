class ObraSocialesController < ApplicationController
  # GET /obra_sociales
  # GET /obra_sociales.json
  def index
    @obra_sociales = ObraSocial.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @obra_sociales }
    end
  end

  # GET /obra_sociales/1
  # GET /obra_sociales/1.json
  def show
    @obra_social = ObraSocial.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @obra_social }
    end
  end

  # GET /obra_sociales/new
  # GET /obra_sociales/new.json
  def new
    @obra_social = ObraSocial.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @obra_social }
    end
  end

  # GET /obra_sociales/1/edit
  def edit
    @obra_social = ObraSocial.find(params[:id])
  end

  # POST /obra_sociales
  # POST /obra_sociales.json
  def create
    @obra_social = ObraSocial.new(params[:obra_social])

    respond_to do |format|
      if @obra_social.save
        format.html { redirect_to @obra_social, notice: 'Obra social was successfully created.' }
        format.json { render json: @obra_social, status: :created, location: @obra_social }
      else
        format.html { render action: "new" }
        format.json { render json: @obra_social.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /obra_sociales/1
  # PUT /obra_sociales/1.json
  def update
    @obra_social = ObraSocial.find(params[:id])

    respond_to do |format|
      if @obra_social.update_attributes(params[:obra_social])
        format.html { redirect_to @obra_social, notice: 'Obra social was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @obra_social.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /obra_sociales/1
  # DELETE /obra_sociales/1.json
  def destroy
    @obra_social = ObraSocial.find(params[:id])
    @obra_social.destroy

    respond_to do |format|
      format.html { redirect_to obra_sociales_url }
      format.json { head :no_content }
    end
  end
end
