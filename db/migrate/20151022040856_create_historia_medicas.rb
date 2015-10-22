class CreateHistoriaMedicas < ActiveRecord::Migration
  def change
    create_table :historia_medicas do |t|
      t.string :codigo
      t.date :fecha
      t.string :doctor

      t.timestamps null: false
    end
  end
end
