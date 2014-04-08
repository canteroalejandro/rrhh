class AddFieldsRefToClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :contador_id, :integer
    add_column :clientes, :actividad_id, :integer
    add_column :clientes, :obra_social_id, :integer
    add_column :clientes, :localidad_id, :integer
    add_column :clientes, :departamento_id, :integer
    add_column :clientes, :provincia_id, :integer
    add_column :clientes, :pais_id, :integer
    add_column :clientes, :tipo_documento_id, :integer

    add_index :clientes, :contador_id
    add_index :clientes, :actividad_id
    add_index :clientes, :obra_social_id
    add_index :clientes, :localidad_id
    add_index :clientes, :departamento_id
    add_index :clientes, :provincia_id
    add_index :clientes, :pais_id
    add_index :clientes, :tipo_documento_id
  end
end