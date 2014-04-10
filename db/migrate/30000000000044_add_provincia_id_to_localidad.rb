class AddProvinciaIdToLocalidad < ActiveRecord::Migration
  def change
    add_column :localidades, :provincia_id, :integer
    add_index :localidades, :provincia_id
  end
end
