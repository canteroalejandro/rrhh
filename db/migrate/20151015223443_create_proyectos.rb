class CreateProyectos < ActiveRecord::Migration
  def change
    create_table :proyectos do |t|
      t.string :codigo
      t.string :nombre

      t.timestamps null: false
    end
  end
end
