class CheckInModify < ActiveRecord::Migration
  def change
    remove_reference :check_ins, :horario_empleado, index: true, foreign_key: true
    add_reference :check_ins, :horario, index: true, foreign_key: true
  end
end
