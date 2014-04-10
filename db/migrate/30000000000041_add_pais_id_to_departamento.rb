class AddPaisIdToDepartamento < ActiveRecord::Migration
  def change
    add_column :departamentos, :pais_id, :integer
    add_index :departamentos, :pais_id
  end
end
