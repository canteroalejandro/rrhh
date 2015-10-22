class AddEmpleadoRefToHistoriaMedica < ActiveRecord::Migration
  def change
    add_reference :historia_medicas, :empleado, index: true, foreign_key: true
  end
end
