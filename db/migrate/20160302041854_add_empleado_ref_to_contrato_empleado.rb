class AddEmpleadoRefToContratoEmpleado < ActiveRecord::Migration
  def change
    add_reference :contrato_empleados, :empleado, index: true, foreign_key: true
  end
end
