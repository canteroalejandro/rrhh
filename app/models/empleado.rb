class Empleado < ActiveRecord::Base
	has_many :historia_medicas
	has_one :categoria

	#validar presencia
	validates :nombre, presence: {message: "El campo Nombre debe ser completado"}
	validates :dni, presence: {message: "El campo DNI debe ser completado"}

	def codigo_empleado
		if Empleado.exists? == false
			empleado = 1
		else
			empleado = Empleado.last.id+1
		end
		return "EMP-00#{empleado}"
	end
end
