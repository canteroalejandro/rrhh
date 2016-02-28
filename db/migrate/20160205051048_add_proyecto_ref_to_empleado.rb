class AddProyectoRefToEmpleado < ActiveRecord::Migration
  def change
    add_reference :empleados, :proyecto, index: true, foreign_key: true
  end
end
