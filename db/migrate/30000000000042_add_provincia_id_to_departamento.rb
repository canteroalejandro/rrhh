class AddProvinciaIdToDepartamento < ActiveRecord::Migration
  def change
    add_column :departamentos, :provincia_id, :integer
    add_index :departamentos, :provincia_id
  end
end
