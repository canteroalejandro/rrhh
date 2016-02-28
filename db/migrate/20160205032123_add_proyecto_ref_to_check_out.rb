class AddProyectoRefToCheckOut < ActiveRecord::Migration
  def change
    add_reference :check_outs, :proyecto, index: true, foreign_key: true
  end
end
