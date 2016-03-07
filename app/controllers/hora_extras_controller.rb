class HoraExtrasController < ApplicationController
  before_action :set_hora_extra, only: [:show, :edit, :update, :destroy]

  # GET /hora_extras
  # GET /hora_extras.json
  def index
    @hora_extras = HoraExtra.all
  end

  # GET /hora_extras/1
  # GET /hora_extras/1.json
  def show
  end

  # GET /hora_extras/new
  def new
    @hora_extra = HoraExtra.new
  end

  # GET /hora_extras/1/edit
  def edit
  end

  # POST /hora_extras
  # POST /hora_extras.json
  def create
    @hora_extra = HoraExtra.new(hora_extra_params)

    respond_to do |format|
      if @hora_extra.save
        format.html { redirect_to @hora_extra, notice: 'Hora extra was successfully created.' }
        format.json { render :show, status: :created, location: @hora_extra }
      else
        format.html { render :new }
        format.json { render json: @hora_extra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hora_extras/1
  # PATCH/PUT /hora_extras/1.json
  def update
    respond_to do |format|
      if @hora_extra.update(hora_extra_params)
        format.html { redirect_to @hora_extra, notice: 'Hora extra was successfully updated.' }
        format.json { render :show, status: :ok, location: @hora_extra }
      else
        format.html { render :edit }
        format.json { render json: @hora_extra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hora_extras/1
  # DELETE /hora_extras/1.json
  def destroy
    @hora_extra.destroy
    respond_to do |format|
      format.html { redirect_to hora_extras_url, notice: 'Hora extra was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hora_extra
      @hora_extra = HoraExtra.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hora_extra_params
      params.require(:hora_extra).permit(:codigo, :nombre, :horaInicio, :horaFin, :precio, dia:[])
    end
end
