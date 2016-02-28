class AddEmpleadoRefToCheckIn < ActiveRecord::Migration
  def change
    add_reference :check_ins, :empleado, index: true, foreign_key: true
  end
end
