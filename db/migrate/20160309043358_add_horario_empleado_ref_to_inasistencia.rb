class AddHorarioEmpleadoRefToInasistencia < ActiveRecord::Migration
  def change
    add_reference :inasistencias, :horario_empleado, index: true, foreign_key: true
  end
end
