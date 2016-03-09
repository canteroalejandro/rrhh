class AddEmpleadoRefToInasistencia < ActiveRecord::Migration
  def change
    add_reference :inasistencias, :empleado, index: true, foreign_key: true
  end
end
