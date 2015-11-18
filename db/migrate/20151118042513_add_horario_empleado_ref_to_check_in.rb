class AddHorarioEmpleadoRefToCheckIn < ActiveRecord::Migration
  def change
    add_reference :check_ins, :horario_empleado, index: true, foreign_key: true
  end
end
