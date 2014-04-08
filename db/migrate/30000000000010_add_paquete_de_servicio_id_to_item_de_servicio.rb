class AddPaqueteDeServicioIdToItemDeServicio < ActiveRecord::Migration
  def change
    add_column :items_de_servicios, :paquete_de_servicio_id, :integer
    add_index :items_de_servicios, :paquete_de_servicio_id
  end
end
