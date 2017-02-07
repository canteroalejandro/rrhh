class AddProyectoToDetalleHorario < ActiveRecord::Migration
  def change
    add_reference :detalle_horarios, :proyecto, index: true, foreign_key: true
  end
end
