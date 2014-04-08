class AddContadorIdToPaqueteDeServicio < ActiveRecord::Migration
  def change
    add_column :paquetes_de_servicios, :contador_id, :integer
    add_index :paquetes_de_servicios, :contador_id
  end
end
