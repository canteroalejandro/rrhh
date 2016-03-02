class AddEmpleadoProyectoRefToCheckOut < ActiveRecord::Migration
  def change
    add_reference :check_outs, :empleado_proyecto, index: true, foreign_key: true
  end
end
