class AddIndeterminadoToContrato < ActiveRecord::Migration
  def change
    add_column :contratos, :indeterminado, :boolean
  end
end
