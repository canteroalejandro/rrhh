class CreateCategorias < ActiveRecord::Migration
  def change
    create_table :categorias do |t|
      t.string :identificador
      t.decimal :montoMaxFacturado
      t.decimal :gastosMaxLuz
      t.date :fechaVigencia

      t.timestamps
    end
  end
end
