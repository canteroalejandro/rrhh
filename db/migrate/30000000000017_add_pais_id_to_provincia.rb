class AddPaisIdToProvincia < ActiveRecord::Migration
  def change
    add_column :provincias, :pai_id, :integer
    add_index :provincias, :pai_id
  end
end