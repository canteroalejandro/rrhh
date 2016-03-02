class AddIncidenciaRefToIncidenciaEmpleado < ActiveRecord::Migration
  def change
    add_reference :incidencia_empleados, :incidencia, index: true, foreign_key: true
  end
end
