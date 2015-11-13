class AddEmpleadoRefToUsuario < ActiveRecord::Migration
  def change
    add_reference :usuarios, :empleado, index: true, foreign_key: true
  end
end
