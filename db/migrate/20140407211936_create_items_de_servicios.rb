class CreateItemsDeServicios < ActiveRecord::Migration
  def change
    create_table :items_de_servicios do |t|
      t.decimal :monto_establecido

      t.timestamps
    end
  end
end
