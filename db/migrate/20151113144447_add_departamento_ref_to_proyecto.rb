class AddDepartamentoRefToProyecto < ActiveRecord::Migration
  def change
    add_reference :proyectos, :departamento, index: true, foreign_key: true
  end
end
