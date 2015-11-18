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

ActiveRecord::Schema.define(version: 20151118050006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "asistencias", force: :cascade do |t|
    t.boolean  "entrada"
    t.boolean  "salida"
    t.string   "outputAsistencia"
    t.decimal  "horasTrabajadas"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "empleado_id"
    t.integer  "horario_id"
    t.integer  "usuario_id"
  end

  add_index "asistencias", ["empleado_id"], name: "index_asistencias_on_empleado_id", using: :btree
  add_index "asistencias", ["horario_id"], name: "index_asistencias_on_horario_id", using: :btree
  add_index "asistencias", ["usuario_id"], name: "index_asistencias_on_usuario_id", using: :btree

  create_table "categorias", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.decimal  "salarioBase"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "check_ins", force: :cascade do |t|
    t.boolean  "tardanza"
    t.datetime "horaOutput"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "horario_empleado_id"
    t.integer  "usuario_id"
  end

  add_index "check_ins", ["horario_empleado_id"], name: "index_check_ins_on_horario_empleado_id", using: :btree
  add_index "check_ins", ["usuario_id"], name: "index_check_ins_on_usuario_id", using: :btree

  create_table "check_outs", force: :cascade do |t|
    t.datetime "horaOutput"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "horario_empleado_id"
    t.integer  "usuario_id"
  end

  add_index "check_outs", ["horario_empleado_id"], name: "index_check_outs_on_horario_empleado_id", using: :btree
  add_index "check_outs", ["usuario_id"], name: "index_check_outs_on_usuario_id", using: :btree

  create_table "departamentos", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.date     "fechaEnQueDirige"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "empleado_id"
  end

  add_index "departamentos", ["empleado_id"], name: "index_departamentos_on_empleado_id", using: :btree

  create_table "empleados", force: :cascade do |t|
    t.string   "codigo"
    t.string   "dni"
    t.string   "nombre"
    t.string   "apellido"
    t.date     "fechaNacimiento"
    t.string   "direccion"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "categoria_id"
    t.integer  "sexo_id"
  end

  add_index "empleados", ["categoria_id"], name: "index_empleados_on_categoria_id", using: :btree
  add_index "empleados", ["sexo_id"], name: "index_empleados_on_sexo_id", using: :btree

  create_table "historia_medicas", force: :cascade do |t|
    t.string   "codigo"
    t.date     "fecha"
    t.string   "doctor"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "empleado_id"
  end

  add_index "historia_medicas", ["empleado_id"], name: "index_historia_medicas_on_empleado_id", using: :btree

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
    t.string   "nombre"
    t.string   "dia"
    t.time     "horaEntrada"
    t.time     "horaSalida"
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

  create_table "proyectos", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "departamento_id"
  end

  add_index "proyectos", ["departamento_id"], name: "index_proyectos_on_departamento_id", using: :btree

  create_table "sexos", force: :cascade do |t|
    t.string   "sexo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "userName"
    t.string   "password"
    t.string   "rol"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "empleado_id"
  end

  add_index "usuarios", ["empleado_id"], name: "index_usuarios_on_empleado_id", using: :btree

  add_foreign_key "asistencias", "empleados"
  add_foreign_key "asistencias", "horarios"
  add_foreign_key "asistencias", "usuarios"
  add_foreign_key "check_ins", "horario_empleados"
  add_foreign_key "check_ins", "usuarios"
  add_foreign_key "check_outs", "horario_empleados"
  add_foreign_key "check_outs", "usuarios"
  add_foreign_key "departamentos", "empleados"
  add_foreign_key "empleados", "categorias"
  add_foreign_key "empleados", "sexos"
  add_foreign_key "historia_medicas", "empleados"
  add_foreign_key "horario_empleados", "empleados"
  add_foreign_key "horario_empleados", "horarios"
  add_foreign_key "horarios", "empleados"
  add_foreign_key "proyectos", "departamentos"
  add_foreign_key "usuarios", "empleados"
end
