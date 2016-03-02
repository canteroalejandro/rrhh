class EmpleadoProyecto < ActiveRecord::Base
	belongs_to :empleado
	belongs_to :proyecto

	def get_proyecto(proy)
		aux= Proyecto.find(proy)
		return "#{aux.nombre}"
	end
end
