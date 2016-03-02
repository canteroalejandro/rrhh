class AddEmpleadoRefToIncidenciaEmpleado < ActiveRecord::Migration
  def change
    add_reference :incidencia_empleados, :empleado, index: true, foreign_key: true
  end
end
