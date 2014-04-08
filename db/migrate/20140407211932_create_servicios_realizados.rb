class CreateServiciosRealizados < ActiveRecord::Migration
  def change
    create_table :servicios_realizados do |t|
      t.string :descripcion
      t.decimal :monto
      t.date :fecha
      t.decimal :bonificacion

      t.timestamps
    end
  end
end
