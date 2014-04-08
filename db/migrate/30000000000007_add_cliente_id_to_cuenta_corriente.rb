class AddClienteIdToCuentaCorriente < ActiveRecord::Migration
  def change
    add_column :cuentas_corrientes, :cliente_id, :integer
    add_index :cuentas_corrientes, :cliente_id
  end
end
