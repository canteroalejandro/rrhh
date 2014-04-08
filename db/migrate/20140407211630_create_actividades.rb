class CreateActividades < ActiveRecord::Migration
  def change
    create_table :actividades do |t|
      t.string :descripcion
      t.string :codigo

      t.timestamps
    end
  end
end
