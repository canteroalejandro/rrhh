class CreateImagenes < ActiveRecord::Migration
  def change
    create_table :imagenes do |t|
      t.string :nombre
      t.date :fecha
      t.string :url_imagen

      t.timestamps
    end
  end
end
