class AddHorarioRefToAsistencia < ActiveRecord::Migration
  def change
    add_reference :asistencias, :horario, index: true, foreign_key: true
  end
end
