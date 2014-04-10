class ApplicationController < ActionController::Base
  protect_from_forgery
  
  add_breadcrumb 'Home', '/'

  def load_direcciones
    @paises = Pais.all
    @provincias = Provincia.all
    @departamentos = Departamento.all
    @localidades = Localidad.all
  end
end
