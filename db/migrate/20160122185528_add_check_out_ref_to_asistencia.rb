class AddCheckOutRefToAsistencia < ActiveRecord::Migration
  def change
    add_reference :asistencias, :check_out, index: true, foreign_key: true
  end
end
