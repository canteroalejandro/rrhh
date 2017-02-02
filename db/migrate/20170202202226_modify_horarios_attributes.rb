class ModifyHorariosAttributes < ActiveRecord::Migration
  def change
    remove_column :horarios, :dia
    remove_column :horarios, :nombre
    remove_column :horarios, :horaEntrada
    remove_column :horarios, :horaSalida
  end
end