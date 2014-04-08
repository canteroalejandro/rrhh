class ContadoresController < ApplicationController
  # GET /contadores
  # GET /contadores.json
  def index
    @contadores = Contador.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contadores }
    end
  end

  # GET /contadores/1
  # GET /contadores/1.json
  def show
    @contador = Contador.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contador }
    end
  end

  # GET /contadores/new
  # GET /contadores/new.json
  def new
    @contador = Contador.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contador }
    end
  end

  # GET /contadores/1/edit
  def edit
    @contador = Contador.find(params[:id])
  end

  # POST /contadores
  # POST /contadores.json
  def create
    @contador = Contador.new(params[:contador])

    respond_to do |format|
      if @contador.save
        format.html { redirect_to @contador, notice: 'Contador was successfully created.' }
        format.json { render json: @contador, status: :created, location: @contador }
      else
        format.html { render action: "new" }
        format.json { render json: @contador.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contadores/1
  # PUT /contadores/1.json
  def update
    @contador = Contador.find(params[:id])

    respond_to do |format|
      if @contador.update_attributes(params[:contador])
        format.html { redirect_to @contador, notice: 'Contador was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contador.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contadores/1
  # DELETE /contadores/1.json
  def destroy
    @contador = Contador.find(params[:id])
    @contador.destroy

    respond_to do |format|
      format.html { redirect_to contadores_url }
      format.json { head :no_content }
    end
  end
end
