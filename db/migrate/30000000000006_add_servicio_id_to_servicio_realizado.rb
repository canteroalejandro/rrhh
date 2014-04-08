class AddServicioIdToServicioRealizado < ActiveRecord::Migration
  def change
    add_column :servicios_realizados, :servicio_id, :integer
    add_index :servicios_realizados, :servicio_id
  end
end
