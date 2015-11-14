class CreateDepartamentos < ActiveRecord::Migration
  def change
    create_table :departamentos do |t|
      t.string :codigo
      t.string :nombre
      t.date :fechaEnQueDirige

      t.timestamps null: false
    end
  end
end
