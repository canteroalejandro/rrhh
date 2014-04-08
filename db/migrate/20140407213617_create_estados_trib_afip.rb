class CreateEstadosTribAfip < ActiveRecord::Migration
  def change
    create_table :estados_trib_afip do |t|
      t.string :clave
      t.date :fechaAlta
      t.string :condicion

      t.timestamps
    end
  end
end
