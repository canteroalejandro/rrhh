class AddFieldsRefToContador < ActiveRecord::Migration
  def change
    add_column :contadores, :localidad_id, :integer
    add_column :contadores, :departamento_id, :integer
    add_column :contadores, :provincia_id, :integer
    add_column :contadores, :pais_id, :integer
    add_column :contadores, :tipo_documento_id, :integer

    add_index :contadores, :localidad_id
    add_index :contadores, :departamento_id
    add_index :contadores, :provincia_id
    add_index :contadores, :pais_id
    add_index :contadores, :tipo_documento_id
  end
end