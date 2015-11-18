class HorarioEmpleado < ActiveRecord::Base
	belongs_to :empleado 
	belongs_to :horario

	def get_nombre_empleado(emp)
		aux= Empleado.find(emp)
		return "#{aux.nombre} #{aux.apellido}"
	end

	def get_horario(hor)
		aux= Horario.find(hor)
		entrada= aux.horaEntrada.strftime("%H:%M %P")
		salida= aux.horaSalida.strftime("%H:%M %P") 
		return "#{aux.nombre} #{entrada}-#{salida}"
	end

end
