class AddTipoDocumentoComercialIdToMovimiento < ActiveRecord::Migration
  def change
    add_column :movimientos, :tipo_documento_comercial_id, :integer
    add_index :movimientos, :tipo_documento_comercial_id
  end
end
