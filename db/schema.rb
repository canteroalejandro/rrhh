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

ActiveRecord::Schema.define(version: 20151022042631) do

  create_table "asistencias", force: :cascade do |t|
    t.boolean  "entrada"
    t.boolean  "salida"
    t.string   "outputAsistencia"
    t.integer  "horasTrabajadas"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "categorias", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.decimal  "salarioBase"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "departamentos", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.datetime "fechaEnQueDirige"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "empleados", force: :cascade do |t|
    t.string   "codigo"
    t.string   "dni"
    t.string   "nombre"
    t.string   "apellido"
    t.string   "sexo"
    t.date     "fechaNacimiento"
    t.string   "direccion"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "historia_medicas", force: :cascade do |t|
    t.string   "codigo"
    t.date     "fecha"
    t.string   "doctor"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "empleado_id"
  end

  add_index "historia_medicas", ["empleado_id"], name: "index_historia_medicas_on_empleado_id"

  create_table "horarios", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.integer  "diaInicio"
    t.integer  "diaFin"
    t.time     "horaInicio"
    t.time     "horaFin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proyectos", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "userName"
    t.string   "password"
    t.string   "rol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
