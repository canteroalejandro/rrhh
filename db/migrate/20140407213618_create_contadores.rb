class CreateContadores < ActiveRecord::Migration
  def change
    create_table :contadores do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
