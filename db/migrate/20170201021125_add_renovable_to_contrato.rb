class AddRenovableToContrato < ActiveRecord::Migration
  def change
    add_column :contratos, :renovable, :boolean
  end
end
