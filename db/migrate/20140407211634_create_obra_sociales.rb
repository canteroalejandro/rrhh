class CreateObraSociales < ActiveRecord::Migration
  def change
    create_table :obra_sociales do |t|
      t.string :nombre
      t.string :detalle

      t.timestamps
    end
  end
end
