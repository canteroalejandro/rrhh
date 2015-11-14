class AddSexoRefToEmpleado < ActiveRecord::Migration
  def change
    add_reference :empleados, :sexo, index: true, foreign_key: true
  end
end
