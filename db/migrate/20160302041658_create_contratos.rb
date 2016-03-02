class CreateContratos < ActiveRecord::Migration
  def change
    create_table :contratos do |t|
      t.string :codigo
      t.string :nombre
      t.integer :nroDuracion
      t.string :tiempoDuracion
      t.integer :horasDia
      t.integer :edadMinima

      t.timestamps null: false
    end
  end
end
