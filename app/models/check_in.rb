class CheckIn < ActiveRecord::Base
	has_one :asistencia, dependent: :destroy
	has_one :check_out, dependent: :destroy
	belongs_to :horario_empleado 
	belongs_to :usuario 
	belongs_to :empleado 

	before_save :set_tardanza

	def get_empleado(user)
		aux= Empleado.find(user.empleado_id)
		return "#{aux.nombre} #{aux.apellido}"
	end

	def get_usuario
		return self.current_user.id
	end

	def set_tardanza
		self.tardanza = false
		hor_emp = HorarioEmpleado.find(self.horario_empleado_id)
		aux= Horario.find(hor_emp.horario_id)
		if (self.horaOutput.strftime("%H%M%S%N") > aux.finMargenEntrada.strftime("%H%M%S%N"))
			self.tardanza = true
		end
	end
end
