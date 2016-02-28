class AddCheckInRefToAsistencia < ActiveRecord::Migration
  def change
    add_reference :asistencias, :check_in, index: true, foreign_key: true
  end
end
