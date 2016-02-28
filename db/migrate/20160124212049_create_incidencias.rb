class CreateIncidencias < ActiveRecord::Migration
  def change
    create_table :incidencias do |t|
      t.string :codigo
      t.string :nombre
      t.integer :nroDuracion
      t.string :tiempoDuracion
      t.boolean :tieneCondiciones
      t.boolean :tienePeriodoHabilitacion
      t.date :fechaInicioHabilitacion
      t.date :fechaFinHabilitacion
      t.boolean :tieneRestriccionAntiguedad
      t.integer :nroAntiguedadMayor
      t.string :tiempoAntiguedadMayor
      t.integer :nroAntiguedadMenor
      t.string :tiempoAntiguedadMenor
      t.boolean :tieneCantPermitidasPorAnio
      t.integer :vecesPermitidasPorAnio
      t.integer :descuento

      t.timestamps null: false
    end
  end
end
