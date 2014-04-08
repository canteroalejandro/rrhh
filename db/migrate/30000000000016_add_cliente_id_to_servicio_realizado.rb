class AddClienteIdToServicioRealizado < ActiveRecord::Migration
  def change
    add_column :servicios_realizados, :cliente_id, :integer
    add_index :servicios_realizados, :cliente_id
  end
end
