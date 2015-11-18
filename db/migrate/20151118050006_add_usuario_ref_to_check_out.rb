class AddUsuarioRefToCheckOut < ActiveRecord::Migration
  def change
    add_reference :check_outs, :usuario, index: true, foreign_key: true
  end
end
