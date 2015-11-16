class CreateHorarios < ActiveRecord::Migration
  def change
    create_table :horarios do |t|
      t.string :codigo
      t.string :nombre
      t.integer :dia
      t.time :horaEntrada
      t.time :horaSalida
      t.boolean :margenEntradaCheck
      t.boolean :margenSalidaCheck
      t.time :inicioMargenEntrada
      t.time :finMargenEntrada
      t.time :inicioMargenSalida
      t.time :finMargenSalida

      t.timestamps null: false
    end
  end
end
