class AddCuentaCorrienteIdToClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :cuenta_corriente_id, :integer
    add_index :clientes, :cuenta_corriente_id
  end
end
