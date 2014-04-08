class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nombre
      t.string :nroCtaMunicipal
      t.string :cbu
      t.string :claveAfip

      t.timestamps
    end
  end
end
