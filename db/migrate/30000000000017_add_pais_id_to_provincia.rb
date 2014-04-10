class AddPaisIdToProvincia < ActiveRecord::Migration
  def change
    add_column :provincias, :pais_id, :integer
    add_index :provincias, :pais_id
  end
end