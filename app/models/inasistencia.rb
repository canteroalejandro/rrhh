class Inasistencia < ActiveRecord::Base

	belongs_to :horario_empleado
	belongs_to :empleado

	def task_registrar_inasistencias
		Empleados.all.each do |emp|
			if emp.horarioEmpleados.exists?
				emp.horarioEmpleados.each do |horario|
					emp.check_ins.yesterday do |checkin|
						if not(checkin.horaOutput.strftime("%X") > horario.horario.horaEntrada.strftime("%X")) and (checkin.horaOutput.strftime("%X") < horario.horario.horaSalida.strftime("%X"))
							if emp.incidencia_empleados.exists?
								emp.incidencia_empleados.each do |incidencia|
									unless (Time.now.yesterday > incidencia.inicio) and (Time.now.yesterday < incidencia.fin)
										inasistencia = Inasistencia.new
										inasistencia.fecha = Time.now.yesterday
										inasistencia.save
									end
								end
							else
								inasistencia = Inasistencia.new
								inasistencia.fecha = Time.now.yesterday
								inasistencia.save
							end
						end
					end
				end	
			end
		end
	end

	def otra_inasistencia
		i = Inasistencia.new
		i.save
	end
end
