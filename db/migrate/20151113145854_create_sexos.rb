class CreateSexos < ActiveRecord::Migration
  def change
    create_table :sexos do |t|
      t.string :sexo

      t.timestamps null: false
    end
  end
end
