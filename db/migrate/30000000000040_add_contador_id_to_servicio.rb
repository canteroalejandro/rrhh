class AddContadorIdToServicio < ActiveRecord::Migration
  def change
    add_column :servicios, :contador_id, :integer
    add_index :servicios, :contador_id
  end
end
