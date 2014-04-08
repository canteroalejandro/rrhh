class CreateTipoDocumentosComerciales < ActiveRecord::Migration
  def change
    create_table :tipo_documentos_comerciales do |t|
      t.string :nombre
      t.string :descripcion

      t.timestamps
    end
  end
end
