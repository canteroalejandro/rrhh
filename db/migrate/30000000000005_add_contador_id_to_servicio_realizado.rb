class AddContadorIdToServicioRealizado < ActiveRecord::Migration
  def change
    add_column :servicios_realizados, :contador_id, :integer
    add_index :servicios_realizados, :contador_id
  end
end
