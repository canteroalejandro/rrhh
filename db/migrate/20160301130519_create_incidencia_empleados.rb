class CreateIncidenciaEmpleados < ActiveRecord::Migration
  def change
    create_table :incidencia_empleados do |t|
      t.datetime :inicio
      t.datetime :fin

      t.timestamps null: false
    end
  end
end
