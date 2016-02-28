class AddCheckInRefToCheckOut < ActiveRecord::Migration
  def change
    add_reference :check_outs, :check_in, index: true, foreign_key: true
  end
end
