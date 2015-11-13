class AddCategoriaRefToEmpleado < ActiveRecord::Migration
  def change
    add_reference :empleados, :categoria, index: true, foreign_key: true
  end
end
