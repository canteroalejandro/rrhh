class IncidenciaEmpleado < ActiveRecord::Base
	belongs_to :empleado 
	belongs_to :incidencia

	before_save :set_finalizacion

	validate :validar_incidencia_segun_antiguedad
	validate :validar_incidencia_segun_periodo_habilitacion

	def get_nombre_empleado(emp)
		aux= Empleado.find(emp)
		return "#{aux.nombre} #{aux.apellido}"
	end

	def get_cantidad_veces_restantes(incidencia)
		aux= Incidencia.find(incidencia)
		if aux.vecesPermitidasPorAnio != nil
			cantVeces = aux.vecesPermitidasPorAnio
		else
			cantVeces = 0
		end
		return "veces restantes #{cantVeces}"
	end

	def set_finalizacion
		aux= Incidencia.find(self.incidencia_id)
		if aux.tiempoDuracion == "días"
			self.fin = self.inicio.advance(days: aux.nroDuracion)
		elsif aux.tiempoDuracion == "semanas"
			self.fin = self.inicio.advance(weeks: aux.nroDuracion)
		elsif aux.tiempoDuracion == "meses"
			self.fin = self.inicio.advance(months: aux.nroDuracion)
		elsif aux.tiempoDuracion == "años"
			self.fin = self.inicio.advance(years: aux.nroDuracion)
		end
	end

	def validar_incidencia_segun_antiguedad
		incidencia = Incidencia.find(self.incidencia_id)
		empleado = Empleado.find(self.empleado_id)
		if (incidencia.tieneCondiciones == true)
			if (empleado.antiguedad != nil) 
				if (incidencia.tieneRestriccionAntiguedad == true)
					if(empleado.antiguedad < incidencia.nroAntiguedadMayor ) 
						errors.add(:base, "El empleado tiene menor antiguedad que la requerida para asignar esta incidencia")
					elsif (incidencia.nroAntiguedadMenor != nil)
						if (empleado.antiguedad > incidencia.nroAntiguedadMenor)	
							errors.add(:base, "El empleado tiene mayor antiguedad que la requerida para asignar esta incidencia")
						end
					end
				end
			else
				errors.add(:base, "El empleado aún no tiene contratos. Antes de asignar una Incidencia es necesario asignar un Contrato al Empleado")
			end
		end
	end

	def validar_incidencia_segun_periodo_habilitacion
		incidencia = Incidencia.find(self.incidencia_id)
		if (incidencia.tieneCondiciones == true)
			if (incidencia.tienePeriodoHabilitacion == true)
				if(self.inicio.strftime("%j") > incidencia.fechaFinHabilitacion.strftime("%j")) and (self.inicio.strftime("%j") < incidencia.fechaInicioHabilitacion.strftime("%j"))
					errors.add(:base, "La fecha elegida esta fuera del periodo habilitado")
				end
			end
		end
	end

end
