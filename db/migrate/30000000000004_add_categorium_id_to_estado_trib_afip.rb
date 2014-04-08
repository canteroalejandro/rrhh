class AddCategoriumIdToEstadoTribAfip < ActiveRecord::Migration
  def change
    add_column :estados_trib_afip, :categoria_id, :integer
    add_index :estados_trib_afip, :categoria_id
  end
end
