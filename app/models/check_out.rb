class CheckOut < ActiveRecord::Base
	has_one :asistencia
	belongs_to :horario_empleado 
	belongs_to :usuario 
	belongs_to :empleado 
	belongs_to :proyecto
	belongs_to :check_in

	validate :hay_entrada
	before_save :set_check_in_id
	after_create :set_check_in_flag
	after_create :update_atributos_asistencia

	def hay_entrada
		emp = Empleado.find(self.empleado_id)
		if CheckIn.where(:empleado_id => emp.id).exists?
			ch = CheckIn.where(:empleado_id => emp.id).last
			if ch.flag == true
				errors.add(:check_in_id, "ya se ha hecho check out para el ultimo check_in")
			end
		else
			errors.add(:check_in_id, "no se puede realizar Check Out si no existe Check In")
		end
	end

	def set_check_in_id
		emp = Empleado.find(self.empleado_id)
		if emp.asistencias.exists?
			asistencia = emp.asistencias.last
			if asistencia.entrada == true
				ch = CheckIn.find(asistencia.check_in_id)
				if ch.flag == false
					self.check_in_id = ch.id
				end
			end
		end
	end

	def set_check_in_flag
		emp = Empleado.find(self.empleado_id)
		if CheckIn.where(:empleado_id => emp.id).exists?
			ch = CheckIn.where(:empleado_id => emp.id).last
			if ch.flag == false
				CheckIn.update(ch.id, flag: true)
			end
		end
	end

	def update_atributos_asistencia
		emp = Empleado.find(self.empleado_id)
		asistencia = emp.asistencias.last
		if (asistencia.entrada == true) and (asistencia.salida == nil)
			asistencia.update(check_out_id: self.id)
			asistencia.update(salida: true, outputAsistencia: asistencia.set_salida_en_pantalla,horasTrabajadas: asistencia.calcular_horas_trabajadas)
		end
	end
end
