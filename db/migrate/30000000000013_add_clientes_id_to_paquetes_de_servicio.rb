class AddClientesIdToPaquetesDeServicio < ActiveRecord::Migration
  def change
    add_column :paquetes_de_servicios, :cliente_id, :integer
    add_index :paquetes_de_servicios, :cliente_id
  end
end
