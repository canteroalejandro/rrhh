class NewDetalleHorario < ActiveRecord::Migration
  def change
    create_table :detalles_horarios do |t|
      t.boolean :tardanza
      t.datetime :horaOutput
      t.boolean :flag, :default => false

      t.timestamps null: false
    end

    add_column :, :dia
    add_column :horarios, :nombre
    add_column :horarios, :horaEntrada
    add_column :horarios, :horaSalida
    add_column :horarios, :margenEntradaCheck
    add_column :horarios, :margenSalidaCheck
    add_column :horarios, :inicioMargenEntrada
    add_column :horarios, :finMargenEntrada
    add_column :horarios, :inicioMargenSalida
    add_column :horarios, :finMargenSalida

    t.string :codigo
    t.string :nombre
    t.string :dia
    t.time :horaEntrada
    t.time :horaSalida
    t.boolean :margenEntradaCheck
    t.boolean :margenSalidaCheck
    t.time :inicioMargenEntrada
    t.time :finMargenEntrada
    t.time :inicioMargenSalida
    t.time :finMargenSalida
  end
end
