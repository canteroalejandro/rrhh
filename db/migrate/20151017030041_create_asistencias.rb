class CreateAsistencias < ActiveRecord::Migration
  def change
    create_table :asistencias do |t|
      t.boolean :entrada
      t.boolean :salida

      t.timestamps null: false
    end
  end
end
