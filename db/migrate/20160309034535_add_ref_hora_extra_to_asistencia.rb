class AddRefHoraExtraToAsistencia < ActiveRecord::Migration
  def change
    add_reference :asistencias, :hora_extra, index: true, foreign_key: true
  end
end
