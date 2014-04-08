class AddClienteIdToImagen < ActiveRecord::Migration
  def change
    add_column :imagenes, :cliente_id, :integer
    add_index :imagenes, :cliente_id
  end
end
