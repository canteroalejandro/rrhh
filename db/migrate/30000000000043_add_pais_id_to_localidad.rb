class AddPaisIdToLocalidad < ActiveRecord::Migration
  def change
    add_column :localidades, :pais_id, :integer
    add_index :localidades, :pais_id
  end
end
