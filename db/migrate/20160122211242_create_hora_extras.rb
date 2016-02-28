class CreateHoraExtras < ActiveRecord::Migration
  def change
    create_table :hora_extras do |t|
      t.string :codigo
      t.string :nombre
      t.string :dia
      t.time :horaInicio
      t.time :horaFin
      t.float :precio

      t.timestamps null: false
    end
  end
end
