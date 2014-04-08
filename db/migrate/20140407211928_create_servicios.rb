class CreateServicios < ActiveRecord::Migration
  def change
    create_table :servicios do |t|
      t.string :descripcion
      t.decimal :monto

      t.timestamps
    end
  end
end
