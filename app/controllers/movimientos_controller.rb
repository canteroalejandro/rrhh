class MovimientosController < ApplicationController
  # GET /movimientos
  # GET /movimientos.json
  def index
    @movimientos = Movimiento.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @movimientos }
    end
  end

  # GET /movimientos/1
  # GET /movimientos/1.json
  def show
    @movimiento = Movimiento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movimiento }
    end
  end

  # GET /movimientos/new
  # GET /movimientos/new.json
  def new
    @movimiento = Movimiento.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @movimiento }
    end
  end

  # GET /movimientos/1/edit
  def edit
    @movimiento = Movimiento.find(params[:id])
  end

  # POST /movimientos
  # POST /movimientos.json
  def create
    @movimiento = Movimiento.new(params[:movimiento])

    respond_to do |format|
      if @movimiento.save
        format.html { redirect_to @movimiento, notice: 'Movimiento was successfully created.' }
        format.json { render json: @movimiento, status: :created, location: @movimiento }
      else
        format.html { render action: "new" }
        format.json { render json: @movimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /movimientos/1
  # PUT /movimientos/1.json
  def update
    @movimiento = Movimiento.find(params[:id])

    respond_to do |format|
      if @movimiento.update_attributes(params[:movimiento])
        format.html { redirect_to @movimiento, notice: 'Movimiento was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @movimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movimientos/1
  # DELETE /movimientos/1.json
  def destroy
    @movimiento = Movimiento.find(params[:id])
    @movimiento.destroy

    respond_to do |format|
      format.html { redirect_to movimientos_url }
      format.json { head :no_content }
    end
  end
end
