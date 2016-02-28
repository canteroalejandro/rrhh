class AddRolRefToUsuario < ActiveRecord::Migration
  def change
    add_reference :usuarios, :rol, index: true, foreign_key: true
  end
end
