class AddEmpleadoRefToHorario < ActiveRecord::Migration
  def change
    add_reference :horarios, :empleado, index: true, foreign_key: true
  end
end
