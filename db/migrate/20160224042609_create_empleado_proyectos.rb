class CreateEmpleadoProyectos < ActiveRecord::Migration
  def change
    create_table :empleado_proyectos do |t|
      t.integer :empleado_id
      t.integer :proyecto_id

      t.timestamps null: false
    end
  end
end
