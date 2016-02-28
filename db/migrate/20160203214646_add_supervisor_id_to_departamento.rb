class AddSupervisorIdToDepartamento < ActiveRecord::Migration
  def change
    add_column :departamentos, :supervisor_id, :integer
  end
end
