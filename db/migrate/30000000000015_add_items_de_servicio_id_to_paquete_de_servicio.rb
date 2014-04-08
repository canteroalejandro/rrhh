class AddItemsDeServicioIdToPaqueteDeServicio < ActiveRecord::Migration
  def change
    add_column :paquetes_de_servicios, :item_de_servicio_id, :integer
    add_index :paquetes_de_servicios, :item_de_servicio_id
  end
end
