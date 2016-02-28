class EmpleadoProyecto < ActiveRecord::Base
	belongs_to :empleado
	belongs_to :proyecto

end
