# Load the rails application
require File.expand_path('../application', __FILE__)

ActiveSupport::Inflector.inflections do |inflect|
  # inflect.clear

  inflect.plural /([aeiou])([A-Z]|_|\$)/, '\1s\2'
  inflect.plural /([rlnd])([A-Z]|_|$)/, '\1es\2'
  inflect.plural /(is)([A-Z]|_|$)/, '\1es'
  inflect.plural /(i)(z)([A-Z]|_|$)/, '\1ces'

  inflect.plural /([aeiou])([A-Z]|_|$)([a-z]+)([rlnd])($)/, '\1s\2\3\4es\5'
  inflect.plural /([rlnd])([A-Z]|_|$)([a-z]+)([aeiou])($)/, '\1es\2\3\4s\5'
  inflect.singular /([aeiou])s([A-Z]|_|$)/, '\1\2'
  inflect.singular /([rlnd])es([A-Z]|_|$)/, '\1\2'
  inflect.singular /([aeiou])s([A-Z]|_|$)([a-z]+)([rlnd])es($)/, '\1\2\3\4\5'
  inflect.singular /([rlnd])es([A-Z]|_|$)([a-z]+)([aeiou])s($)/, '\1\2\3\4\5'

  inflect.irregular 'cliente', 'clientes'
  inflect.irregular 'provincia', 'provincias'
  inflect.irregular 'pais', 'paises'
  inflect.irregular 'servicio_realizado', 'servicios_realizados'
  inflect.irregular 'estado_trib_afip', 'estados_trib_afip'
  inflect.irregular 'obra_social', 'obra_sociales'
  inflect.irregular 'item_de_servicio', 'items_de_servicios'
  inflect.irregular 'paquete_de_servicio', 'paquetes_de_servicios'
  inflect.irregular 'tipo_documento_comercial', 'tipo_documentos_comerciales'
end

# Initialize the rails application
Myapp::Application.initialize!