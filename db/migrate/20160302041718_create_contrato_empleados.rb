class CreateContratoEmpleados < ActiveRecord::Migration
  def change
    create_table :contrato_empleados do |t|
      t.date :inicio
      t.date :fin

      t.timestamps null: false
    end
  end
end
