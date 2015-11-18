class AddEmpleadoRefToHorarioEmpleado < ActiveRecord::Migration
  def change
    add_reference :horario_empleados, :empleado, index: true, foreign_key: true
  end
end
