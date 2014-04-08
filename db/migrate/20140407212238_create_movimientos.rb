class CreateMovimientos < ActiveRecord::Migration
  def change
    create_table :movimientos do |t|
      t.date :fecha
      t.string :descripcion
      t.string :nro_documento
      t.boolean :debe
      t.boolean :haber
      t.decimal :bonifPaqServ
      t.decimal :bonifManual

      t.timestamps
    end
  end
end
