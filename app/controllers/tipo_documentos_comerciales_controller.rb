class TipoDocumentosComercialesController < ApplicationController
  # GET /tipo_documentos_comerciales
  # GET /tipo_documentos_comerciales.json
  def index
    @tipo_documentos_comerciales = TipoDocumentoComercial.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tipo_documentos_comerciales }
    end
  end

  # GET /tipo_documentos_comerciales/1
  # GET /tipo_documentos_comerciales/1.json
  def show
    @tipo_documento_comercial = TipoDocumentoComercial.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tipo_documento_comercial }
    end
  end

  # GET /tipo_documentos_comerciales/new
  # GET /tipo_documentos_comerciales/new.json
  def new
    @tipo_documento_comercial = TipoDocumentoComercial.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tipo_documento_comercial }
    end
  end

  # GET /tipo_documentos_comerciales/1/edit
  def edit
    @tipo_documento_comercial = TipoDocumentoComercial.find(params[:id])
  end

  # POST /tipo_documentos_comerciales
  # POST /tipo_documentos_comerciales.json
  def create
    @tipo_documento_comercial = TipoDocumentoComercial.new(params[:tipo_documento_comercial])

    respond_to do |format|
      if @tipo_documento_comercial.save
        format.html { redirect_to @tipo_documento_comercial, notice: 'Tipo documento comercial was successfully created.' }
        format.json { render json: @tipo_documento_comercial, status: :created, location: @tipo_documento_comercial }
      else
        format.html { render action: "new" }
        format.json { render json: @tipo_documento_comercial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tipo_documentos_comerciales/1
  # PUT /tipo_documentos_comerciales/1.json
  def update
    @tipo_documento_comercial = TipoDocumentoComercial.find(params[:id])

    respond_to do |format|
      if @tipo_documento_comercial.update_attributes(params[:tipo_documento_comercial])
        format.html { redirect_to @tipo_documento_comercial, notice: 'Tipo documento comercial was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tipo_documento_comercial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_documentos_comerciales/1
  # DELETE /tipo_documentos_comerciales/1.json
  def destroy
    @tipo_documento_comercial = TipoDocumentoComercial.find(params[:id])
    @tipo_documento_comercial.destroy

    respond_to do |format|
      format.html { redirect_to tipo_documentos_comerciales_url }
      format.json { head :no_content }
    end
  end
end
