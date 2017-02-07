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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170206203642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "asistencias", force: :cascade do |t|
    t.boolean  "entrada"
    t.boolean  "salida"
    t.string   "outputAsistencia"
    t.float    "horasTrabajadas"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "empleado_id"
    t.integer  "horario_id"
    t.integer  "usuario_id"
    t.integer  "check_in_id"
    t.integer  "check_out_id"
    t.integer  "hora_extra_id"
  end

  add_index "asistencias", ["check_in_id"], name: "index_asistencias_on_check_in_id", using: :btree
  add_index "asistencias", ["check_out_id"], name: "index_asistencias_on_check_out_id", using: :btree
  add_index "asistencias", ["empleado_id"], name: "index_asistencias_on_empleado_id", using: :btree
  add_index "asistencias", ["hora_extra_id"], name: "index_asistencias_on_hora_extra_id", using: :btree
  add_index "asistencias", ["horario_id"], name: "index_asistencias_on_horario_id", using: :btree
  add_index "asistencias", ["usuario_id"], name: "index_asistencias_on_usuario_id", using: :btree

  create_table "categorias", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.decimal  "salarioBase"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "descripcion"
  end

  create_table "check_ins", force: :cascade do |t|
    t.boolean  "tardanza"
    t.datetime "horaOutput"
    t.boolean  "flag",        default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "usuario_id"
    t.integer  "empleado_id"
    t.integer  "horario_id"
  end

  add_index "check_ins", ["empleado_id"], name: "index_check_ins_on_empleado_id", using: :btree
  add_index "check_ins", ["horario_id"], name: "index_check_ins_on_horario_id", using: :btree
  add_index "check_ins", ["usuario_id"], name: "index_check_ins_on_usuario_id", using: :btree

  create_table "check_outs", force: :cascade do |t|
    t.datetime "horaOutput"
    t.integer  "horasTrabajadasProyecto"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "horario_empleado_id"
    t.integer  "usuario_id"
    t.integer  "empleado_id"
    t.integer  "check_in_id"
    t.integer  "empleado_proyecto_id"
  end

  add_index "check_outs", ["check_in_id"], name: "index_check_outs_on_check_in_id", using: :btree
  add_index "check_outs", ["empleado_id"], name: "index_check_outs_on_empleado_id", using: :btree
  add_index "check_outs", ["empleado_proyecto_id"], name: "index_check_outs_on_empleado_proyecto_id", using: :btree
  add_index "check_outs", ["horario_empleado_id"], name: "index_check_outs_on_horario_empleado_id", using: :btree
  add_index "check_outs", ["usuario_id"], name: "index_check_outs_on_usuario_id", using: :btree

  create_table "contrato_empleados", force: :cascade do |t|
    t.date     "inicio"
    t.date     "fin"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "contrato_id"
    t.integer  "empleado_id"
  end

  add_index "contrato_empleados", ["contrato_id"], name: "index_contrato_empleados_on_contrato_id", using: :btree
  add_index "contrato_empleados", ["empleado_id"], name: "index_contrato_empleados_on_empleado_id", using: :btree

  create_table "contratos", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.integer  "nroDuracion"
    t.string   "tiempoDuracion"
    t.integer  "horasDia"
    t.integer  "edadMinima"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "renovable"
  end

  create_table "departamentos", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.date     "fechaEnQueDirige"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "empleado_id"
    t.integer  "supervisor_id"
  end

  add_index "departamentos", ["empleado_id"], name: "index_departamentos_on_empleado_id", using: :btree

  create_table "detalle_horarios", force: :cascade do |t|
    t.integer  "dia"
    t.datetime "horaEntrada"
    t.datetime "horaSalida"
    t.integer  "horario_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "proyecto_id"
  end

  add_index "detalle_horarios", ["horario_id"], name: "index_detalle_horarios_on_horario_id", using: :btree
  add_index "detalle_horarios", ["proyecto_id"], name: "index_detalle_horarios_on_proyecto_id", using: :btree

  create_table "empleado_proyectos", force: :cascade do |t|
    t.integer  "empleado_id"
    t.integer  "proyecto_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "empleados", force: :cascade do |t|
    t.string   "codigo"
    t.string   "dni"
    t.string   "nombre"
    t.string   "apellido"
    t.date     "fechaNacimiento"
    t.string   "direccion"
    t.integer  "antiguedad"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "categoria_id"
    t.integer  "departamento_id"
    t.integer  "proyecto_id"
  end

  add_index "empleados", ["categoria_id"], name: "index_empleados_on_categoria_id", using: :btree
  add_index "empleados", ["departamento_id"], name: "index_empleados_on_departamento_id", using: :btree
  add_index "empleados", ["proyecto_id"], name: "index_empleados_on_proyecto_id", using: :btree

  create_table "feriados", force: :cascade do |t|
    t.string   "descripcion"
    t.date     "fecha"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "historia_medicas", force: :cascade do |t|
    t.string   "codigo"
    t.date     "fecha"
    t.string   "doctor"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "empleado_id"
  end

  add_index "historia_medicas", ["empleado_id"], name: "index_historia_medicas_on_empleado_id", using: :btree

  create_table "hora_extras", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.string   "dia"
    t.time     "horaInicio"
    t.time     "horaFin"
    t.float    "precio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "horario_empleados", force: :cascade do |t|
    t.date     "fechaInicio"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "horario_id"
    t.integer  "empleado_id"
  end

  add_index "horario_empleados", ["empleado_id"], name: "index_horario_empleados_on_empleado_id", using: :btree
  add_index "horario_empleados", ["horario_id"], name: "index_horario_empleados_on_horario_id", using: :btree

  create_table "horarios", force: :cascade do |t|
    t.string   "codigo"
    t.boolean  "margenEntradaCheck"
    t.boolean  "margenSalidaCheck"
    t.time     "inicioMargenEntrada"
    t.time     "finMargenEntrada"
    t.time     "inicioMargenSalida"
    t.time     "finMargenSalida"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "empleado_id"
  end

  add_index "horarios", ["empleado_id"], name: "index_horarios_on_empleado_id", using: :btree

  create_table "inasistencias", force: :cascade do |t|
    t.date     "fecha"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "empleado_id"
    t.integer  "horario_empleado_id"
  end

  add_index "inasistencias", ["empleado_id"], name: "index_inasistencias_on_empleado_id", using: :btree
  add_index "inasistencias", ["horario_empleado_id"], name: "index_inasistencias_on_horario_empleado_id", using: :btree

  create_table "incidencia_empleados", force: :cascade do |t|
    t.datetime "inicio"
    t.datetime "fin"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "incidencia_id"
    t.integer  "empleado_id"
  end

  add_index "incidencia_empleados", ["empleado_id"], name: "index_incidencia_empleados_on_empleado_id", using: :btree
  add_index "incidencia_empleados", ["incidencia_id"], name: "index_incidencia_empleados_on_incidencia_id", using: :btree

  create_table "incidencias", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.integer  "nroDuracion"
    t.string   "tiempoDuracion"
    t.boolean  "tieneCondiciones"
    t.boolean  "tienePeriodoHabilitacion"
    t.date     "fechaInicioHabilitacion"
    t.date     "fechaFinHabilitacion"
    t.boolean  "tieneRestriccionAntiguedad"
    t.integer  "nroAntiguedadMayor"
    t.string   "tiempoAntiguedadMayor"
    t.integer  "nroAntiguedadMenor"
    t.string   "tiempoAntiguedadMenor"
    t.boolean  "tieneCantPermitidasPorAnio"
    t.integer  "vecesPermitidasPorAnio"
    t.integer  "descuento"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "proyectos", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "departamento_id"
    t.integer  "empleado_id"
  end

  add_index "proyectos", ["departamento_id"], name: "index_proyectos_on_departamento_id", using: :btree
  add_index "proyectos", ["empleado_id"], name: "index_proyectos_on_empleado_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "userName"
    t.string   "password"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "empleado_id"
    t.integer  "rol_id"
  end

  add_index "usuarios", ["empleado_id"], name: "index_usuarios_on_empleado_id", using: :btree
  add_index "usuarios", ["rol_id"], name: "index_usuarios_on_rol_id", using: :btree

  add_foreign_key "asistencias", "check_ins"
  add_foreign_key "asistencias", "check_outs"
  add_foreign_key "asistencias", "empleados"
  add_foreign_key "asistencias", "hora_extras"
  add_foreign_key "asistencias", "horarios"
  add_foreign_key "asistencias", "usuarios"
  add_foreign_key "check_ins", "empleados"
  add_foreign_key "check_ins", "horarios"
  add_foreign_key "check_ins", "usuarios"
  add_foreign_key "check_outs", "check_ins"
  add_foreign_key "check_outs", "empleado_proyectos"
  add_foreign_key "check_outs", "empleados"
  add_foreign_key "check_outs", "horario_empleados"
  add_foreign_key "check_outs", "usuarios"
  add_foreign_key "contrato_empleados", "contratos"
  add_foreign_key "contrato_empleados", "empleados"
  add_foreign_key "departamentos", "empleados"
  add_foreign_key "detalle_horarios", "horarios"
  add_foreign_key "detalle_horarios", "proyectos"
  add_foreign_key "empleados", "categorias"
  add_foreign_key "empleados", "departamentos"
  add_foreign_key "empleados", "proyectos"
  add_foreign_key "historia_medicas", "empleados"
  add_foreign_key "horario_empleados", "empleados"
  add_foreign_key "horario_empleados", "horarios"
  add_foreign_key "horarios", "empleados"
  add_foreign_key "inasistencias", "empleados"
  add_foreign_key "inasistencias", "horario_empleados"
  add_foreign_key "incidencia_empleados", "empleados"
  add_foreign_key "incidencia_empleados", "incidencias"
  add_foreign_key "proyectos", "departamentos"
  add_foreign_key "proyectos", "empleados"
  add_foreign_key "usuarios", "empleados"
  add_foreign_key "usuarios", "roles"
end
