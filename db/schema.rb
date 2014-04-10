# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 30000000000046) do

  create_table "actividades", :force => true do |t|
    t.string   "descripcion"
    t.string   "codigo"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "categorias", :force => true do |t|
    t.string   "identificador"
    t.decimal  "montoMaxFacturado"
    t.decimal  "gastosMaxLuz"
    t.date     "fechaVigencia"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "clientes", :force => true do |t|
    t.string   "nombre"
    t.string   "nroCtaMunicipal"
    t.string   "cbu"
    t.string   "claveAfip"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "cuenta_corriente_id"
    t.integer  "contador_id"
    t.integer  "actividad_id"
    t.integer  "obra_social_id"
    t.integer  "localidad_id"
    t.integer  "departamento_id"
    t.integer  "provincia_id"
    t.integer  "pais_id"
    t.integer  "tipo_documento_id"
    t.integer  "estadoTribAfipActual"
  end

  add_index "clientes", ["actividad_id"], :name => "index_clientes_on_actividad_id"
  add_index "clientes", ["contador_id"], :name => "index_clientes_on_contador_id"
  add_index "clientes", ["cuenta_corriente_id"], :name => "index_clientes_on_cuenta_corriente_id"
  add_index "clientes", ["departamento_id"], :name => "index_clientes_on_departamento_id"
  add_index "clientes", ["estadoTribAfipActual"], :name => "index_clientes_on_estadoTribAfipActual"
  add_index "clientes", ["localidad_id"], :name => "index_clientes_on_localidad_id"
  add_index "clientes", ["obra_social_id"], :name => "index_clientes_on_obra_social_id"
  add_index "clientes", ["pais_id"], :name => "index_clientes_on_pais_id"
  add_index "clientes", ["provincia_id"], :name => "index_clientes_on_provincia_id"
  add_index "clientes", ["tipo_documento_id"], :name => "index_clientes_on_tipo_documento_id"

  create_table "contadores", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "localidad_id"
    t.integer  "departamento_id"
    t.integer  "provincia_id"
    t.integer  "pais_id"
    t.integer  "tipo_documento_id"
  end

  add_index "contadores", ["departamento_id"], :name => "index_contadores_on_departamento_id"
  add_index "contadores", ["localidad_id"], :name => "index_contadores_on_localidad_id"
  add_index "contadores", ["pais_id"], :name => "index_contadores_on_pais_id"
  add_index "contadores", ["provincia_id"], :name => "index_contadores_on_provincia_id"
  add_index "contadores", ["tipo_documento_id"], :name => "index_contadores_on_tipo_documento_id"

  create_table "cuentas_corrientes", :force => true do |t|
    t.string   "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "cliente_id"
  end

  add_index "cuentas_corrientes", ["cliente_id"], :name => "index_cuentas_corrientes_on_cliente_id"

  create_table "departamentos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "pais_id"
    t.integer  "provincia_id"
  end

  add_index "departamentos", ["pais_id"], :name => "index_departamentos_on_pais_id"
  add_index "departamentos", ["provincia_id"], :name => "index_departamentos_on_provincia_id"

  create_table "estados_trib_afip", :force => true do |t|
    t.string   "clave"
    t.date     "fechaAlta"
    t.string   "condicion"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "cliente_id"
    t.integer  "categoria_id"
  end

  add_index "estados_trib_afip", ["categoria_id"], :name => "index_estados_trib_afip_on_categoria_id"
  add_index "estados_trib_afip", ["cliente_id"], :name => "index_estados_trib_afip_on_cliente_id"

  create_table "imagenes", :force => true do |t|
    t.string   "nombre"
    t.date     "fecha"
    t.string   "url_imagen"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "cliente_id"
  end

  add_index "imagenes", ["cliente_id"], :name => "index_imagenes_on_cliente_id"

  create_table "items_de_servicios", :force => true do |t|
    t.decimal  "monto_establecido"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "paquete_de_servicio_id"
    t.integer  "servicio_id"
  end

  add_index "items_de_servicios", ["paquete_de_servicio_id"], :name => "index_items_de_servicios_on_paquete_de_servicio_id"
  add_index "items_de_servicios", ["servicio_id"], :name => "index_items_de_servicios_on_servicio_id"

  create_table "localidades", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "pais_id"
    t.integer  "provincia_id"
    t.integer  "departamento_id"
  end

  add_index "localidades", ["departamento_id"], :name => "index_localidades_on_departamento_id"
  add_index "localidades", ["pais_id"], :name => "index_localidades_on_pais_id"
  add_index "localidades", ["provincia_id"], :name => "index_localidades_on_provincia_id"

  create_table "movimientos", :force => true do |t|
    t.date     "fecha"
    t.string   "descripcion"
    t.string   "nro_documento"
    t.boolean  "debe"
    t.boolean  "haber"
    t.decimal  "bonifPaqServ"
    t.decimal  "bonifManual"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "cuenta_corriente_id"
    t.integer  "tipo_documento_comercial_id"
  end

  add_index "movimientos", ["cuenta_corriente_id"], :name => "index_movimientos_on_cuenta_corriente_id"
  add_index "movimientos", ["tipo_documento_comercial_id"], :name => "index_movimientos_on_tipo_documento_comercial_id"

  create_table "obra_sociales", :force => true do |t|
    t.string   "nombre"
    t.string   "detalle"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "paises", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "paquetes_de_servicios", :force => true do |t|
    t.string   "descripcion"
    t.decimal  "monto"
    t.boolean  "activo"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "cliente_id"
    t.integer  "item_de_servicio_id"
    t.integer  "contador_id"
  end

  add_index "paquetes_de_servicios", ["cliente_id"], :name => "index_paquetes_de_servicios_on_cliente_id"
  add_index "paquetes_de_servicios", ["contador_id"], :name => "index_paquetes_de_servicios_on_contador_id"
  add_index "paquetes_de_servicios", ["item_de_servicio_id"], :name => "index_paquetes_de_servicios_on_item_de_servicio_id"

  create_table "provincias", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "pais_id"
  end

  add_index "provincias", ["pais_id"], :name => "index_provincias_on_pais_id"

  create_table "servicios", :force => true do |t|
    t.string   "descripcion"
    t.decimal  "monto"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "contador_id"
  end

  add_index "servicios", ["contador_id"], :name => "index_servicios_on_contador_id"

  create_table "servicios_realizados", :force => true do |t|
    t.string   "descripcion"
    t.decimal  "monto"
    t.date     "fecha"
    t.decimal  "bonificacion"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "contador_id"
    t.integer  "servicio_id"
    t.integer  "cliente_id"
  end

  add_index "servicios_realizados", ["cliente_id"], :name => "index_servicios_realizados_on_cliente_id"
  add_index "servicios_realizados", ["contador_id"], :name => "index_servicios_realizados_on_contador_id"
  add_index "servicios_realizados", ["servicio_id"], :name => "index_servicios_realizados_on_servicio_id"

  create_table "tipo_documentos_comerciales", :force => true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
