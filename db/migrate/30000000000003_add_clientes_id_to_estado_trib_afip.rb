class AddClientesIdToEstadoTribAfip < ActiveRecord::Migration
  def change
    add_column :estados_trib_afip, :cliente_id, :integer
    add_index :estados_trib_afip, :cliente_id
  end
end
