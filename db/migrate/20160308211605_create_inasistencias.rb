class CreateInasistencias < ActiveRecord::Migration
  def change
    create_table :inasistencias do |t|
      t.date :fecha

      t.timestamps null: false
    end
  end
end
