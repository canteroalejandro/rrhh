class CreateFeriados < ActiveRecord::Migration
  def change
    create_table :feriados do |t|
      t.string :descripcion
      t.date :fecha

      t.timestamps null: false
    end
  end
end
