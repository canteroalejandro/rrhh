class CuentasCorrientesController < ApplicationController
  # GET /cuentas_corrientes
  # GET /cuentas_corrientes.json
  def index
    @cuentas_corrientes = CuentaCorriente.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cuentas_corrientes }
    end
  end

  # GET /cuentas_corrientes/1
  # GET /cuentas_corrientes/1.json
  def show
    @cuenta_corriente = CuentaCorriente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cuenta_corriente }
    end
  end

  # GET /cuentas_corrientes/new
  # GET /cuentas_corrientes/new.json
  def new
    @cuenta_corriente = CuentaCorriente.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cuenta_corriente }
    end
  end

  # GET /cuentas_corrientes/1/edit
  def edit
    @cuenta_corriente = CuentaCorriente.find(params[:id])
  end

  # POST /cuentas_corrientes
  # POST /cuentas_corrientes.json
  def create
    @cuenta_corriente = CuentaCorriente.new(params[:cuenta_corriente])

    respond_to do |format|
      if @cuenta_corriente.save
        format.html { redirect_to @cuenta_corriente, notice: 'Cuenta corriente was successfully created.' }
        format.json { render json: @cuenta_corriente, status: :created, location: @cuenta_corriente }
      else
        format.html { render action: "new" }
        format.json { render json: @cuenta_corriente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cuentas_corrientes/1
  # PUT /cuentas_corrientes/1.json
  def update
    @cuenta_corriente = CuentaCorriente.find(params[:id])

    respond_to do |format|
      if @cuenta_corriente.update_attributes(params[:cuenta_corriente])
        format.html { redirect_to @cuenta_corriente, notice: 'Cuenta corriente was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cuenta_corriente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cuentas_corrientes/1
  # DELETE /cuentas_corrientes/1.json
  def destroy
    @cuenta_corriente = CuentaCorriente.find(params[:id])
    @cuenta_corriente.destroy

    respond_to do |format|
      format.html { redirect_to cuentas_corrientes_url }
      format.json { head :no_content }
    end
  end
end
