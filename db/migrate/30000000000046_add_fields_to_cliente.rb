class AddFieldsToCliente < ActiveRecord::Migration
  def change
    add_column :clientes, :estadoTribAfipActual, :integer
    add_index :clientes, :estadoTribAfipActual
  end
end
