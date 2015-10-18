class CreateCategorias < ActiveRecord::Migration
  def change
    create_table :categorias do |t|
      t.string :codigo
      t.string :nombre
      t.decimal :salarioBase

      t.timestamps null: false
    end
  end
end
