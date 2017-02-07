class CreateDetalleHorarios < ActiveRecord::Migration
  def change
    create_table :detalle_horarios do |t|
      t.integer :dia
      t.datetime :horaEntrada
      t.datetime :horaSalida
      t.references :horario, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
