class AddUsuarioRefToCheckIn < ActiveRecord::Migration
  def change
    add_reference :check_ins, :usuario, index: true, foreign_key: true
  end
end
