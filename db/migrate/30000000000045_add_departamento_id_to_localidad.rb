class AddDepartamentoIdToLocalidad < ActiveRecord::Migration
  def change
    add_column :localidades, :departamento_id, :integer
    add_index :localidades, :departamento_id
  end
end
