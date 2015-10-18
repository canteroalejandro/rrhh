class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #add_breadcrumb 'Home', '/'

  # def load_direcciones
  #   @paises = Pais.all
  #   @provincias = Provincia.all
  #   @departamentos = Departamento.all
  #   @localidades = Localidad.all
  # end
  helper_method :current_user

  private

  def current_user
	  @current_user ||= Usuario.find(session[:usuario_id]) if session[:usuario_id]
  end
end
