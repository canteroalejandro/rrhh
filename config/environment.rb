# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Myapp::Application.initialize!

ActiveSupport::Inflector.inflections do |inflect|
  inflect.clear :all

  inflect.plural /([^djlnrs])([A-Z]|_|$)/, '\1s\2'
  inflect.plural /([djlnrs])([A-Z]|_|$)/, '\1es\2'
  inflect.plural /(.*)z([A-Z]|_|$)$/i, '\1ces\2'

  inflect.singular /([^djlnrs])s([A-Z]|_|$)/, '\1\2'
  inflect.singular /([djlnrs])es([A-Z]|_|$)/, '\1\2'
  inflect.singular /(.*)ces([A-Z]|_|$)$/i, '\1z\2'

  inflect.irregular 'estado_trib_afip', 'estados_trib_afip'
  inflect.irregular 'item_de_servicio', 'items_de_servicios'
  inflect.irregular 'paquete_de_servicio', 'paquetes_de_servicios'
  inflect.irregular 'tipo_documento_comercial', 'tipo_documentos_comerciales'
end