class CreateCuentasCorrientes < ActiveRecord::Migration
  def change
    create_table :cuentas_corrientes do |t|
      t.string :descripcion

      t.timestamps
    end
  end
end
