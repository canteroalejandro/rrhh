class AddHorarioEmpleadoRefToCheckOut < ActiveRecord::Migration
  def change
    add_reference :check_outs, :horario_empleado, index: true, foreign_key: true
  end
end
