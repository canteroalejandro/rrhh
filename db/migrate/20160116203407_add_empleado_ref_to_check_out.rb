class AddEmpleadoRefToCheckOut < ActiveRecord::Migration
  def change
    add_reference :check_outs, :empleado, index: true, foreign_key: true
  end
end
