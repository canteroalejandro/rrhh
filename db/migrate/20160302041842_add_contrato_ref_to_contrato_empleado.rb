class AddContratoRefToContratoEmpleado < ActiveRecord::Migration
  def change
    add_reference :contrato_empleados, :contrato, index: true, foreign_key: true
  end
end
