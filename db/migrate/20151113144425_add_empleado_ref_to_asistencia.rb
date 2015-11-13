class AddEmpleadoRefToAsistencia < ActiveRecord::Migration
  def change
    add_reference :asistencias, :empleado, index: true, foreign_key: true
  end
end
