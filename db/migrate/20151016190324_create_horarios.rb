class CreateHorarios < ActiveRecord::Migration
  def change
    create_table :horarios do |t|
      t.string :codigo
      t.string :nombre
      t.integer :diaInicio
      t.integer :diaFin
      t.time :horaInicio
      t.time :horaFin

      t.timestamps null: false
    end
  end
end
