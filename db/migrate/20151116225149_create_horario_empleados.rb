class CreateHorarioEmpleados < ActiveRecord::Migration
  def change
    create_table :horario_empleados do |t|
      t.date :fechaInicio	

      t.timestamps null: false
    end
  end
end
