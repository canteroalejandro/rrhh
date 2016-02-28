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

  before_filter do
    resource = controller_path.singularize.gsub('/', '_').to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
end
