class AddCuentaCorrienteIdToMovimiento < ActiveRecord::Migration
  def change
    add_column :movimientos, :cuenta_corriente_id, :integer
    add_index :movimientos, :cuenta_corriente_id
  end
end
