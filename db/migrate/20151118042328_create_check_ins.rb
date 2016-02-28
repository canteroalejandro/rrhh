class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.boolean :tardanza
      t.datetime :horaOutput
      t.boolean :flag, :default => false

      t.timestamps null: false
    end
  end
end
