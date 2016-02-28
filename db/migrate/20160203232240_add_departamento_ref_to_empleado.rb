class AddDepartamentoRefToEmpleado < ActiveRecord::Migration
  def change
    add_reference :empleados, :departamento, index: true, foreign_key: true
  end
end
