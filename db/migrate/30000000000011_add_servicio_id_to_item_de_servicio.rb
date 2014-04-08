class AddServicioIdToItemDeServicio < ActiveRecord::Migration
  def change
    add_column :items_de_servicios, :servicio_id, :integer
    add_index :items_de_servicios, :servicio_id
  end
end
