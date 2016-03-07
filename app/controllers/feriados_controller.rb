class FeriadosController < ApplicationController
  before_action :set_feriado, only: [:show, :edit, :update, :destroy]

  # GET /feriados
  # GET /feriados.json
  def index
    @feriados = Feriado.all
  end

  # GET /feriados/1
  # GET /feriados/1.json
  def show
  end

  # GET /feriados/new
  def new
    @feriado = Feriado.new
  end

  # GET /feriados/1/edit
  def edit
  end

  # POST /feriados
  # POST /feriados.json
  def create
    @feriado = Feriado.new(feriado_params)

    respond_to do |format|
      if @feriado.save
        format.html { redirect_to @feriado, notice: 'Feriado was successfully created.' }
        format.json { render :show, status: :created, location: @feriado }
      else
        format.html { render :new }
        format.json { render json: @feriado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feriados/1
  # PATCH/PUT /feriados/1.json
  def update
    respond_to do |format|
      if @feriado.update(feriado_params)
        format.html { redirect_to @feriado, notice: 'Feriado was successfully updated.' }
        format.json { render :show, status: :ok, location: @feriado }
      else
        format.html { render :edit }
        format.json { render json: @feriado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feriados/1
  # DELETE /feriados/1.json
  def destroy
    @feriado.destroy
    respond_to do |format|
      format.html { redirect_to feriados_url, notice: 'Feriado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feriado
      @feriado = Feriado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feriado_params
      params.require(:feriado).permit(:descripcion, :fecha)
    end
end
