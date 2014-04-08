class CreatePaquetesDeServicios < ActiveRecord::Migration
  def change
    create_table :paquetes_de_servicios do |t|
      t.string :descripcion
      t.decimal :monto
      t.boolean :activo

      t.timestamps
    end
  end
end
