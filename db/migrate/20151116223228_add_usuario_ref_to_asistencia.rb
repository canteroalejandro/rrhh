class AddUsuarioRefToAsistencia < ActiveRecord::Migration
  def change
    add_reference :asistencias, :usuario, index: true, foreign_key: true
  end
end
