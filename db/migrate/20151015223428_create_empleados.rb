class CreateEmpleados < ActiveRecord::Migration
  def change
    create_table :empleados do |t|
      t.string :codigo
      t.string :dni
      t.string :nombre
      t.string :apellido
      t.date :fechaNacimiento
      t.string :direccion

      t.timestamps null: false
    end
  end
end
