class AddHorarioRefToHorarioEmpleado < ActiveRecord::Migration
  def change
    add_reference :horario_empleados, :horario, index: true, foreign_key: true
  end
end
