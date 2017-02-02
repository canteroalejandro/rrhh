class AddDescripcionToCategoria < ActiveRecord::Migration
  def change
    add_column :categorias, :descripcion, :string
  end
end
