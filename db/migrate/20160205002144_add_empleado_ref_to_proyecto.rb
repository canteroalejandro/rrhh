class AddEmpleadoRefToProyecto < ActiveRecord::Migration
  def change
    add_reference :proyectos, :empleado, index: true, foreign_key: true
  end
end
