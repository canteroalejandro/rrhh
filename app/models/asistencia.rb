class Asistencia < ActiveRecord::Base

	belongs_to :empleado
	belongs_to :check_in
	belongs_to :check_out
	has_one :proyecto, through: :check_out
	
	def set_salida_en_pantalla
		check_in = CheckIn.find(self.check_in_id)
		check_out = CheckOut.find(self.check_out_id)
		return"Entrada: #{check_in.horaOutput.strftime("%e/%m/%y %H:%M")} - Salida: #{check_out.horaOutput.strftime("%e/%m/%y %H:%M")}"		
	end

	def calcular_horas_trabajadas
		check_in = CheckIn.find(self.check_in_id)
		check_out = CheckOut.find(self.check_out_id)
		diferencia = TimeDifference.between(check_in.horaOutput, check_out.horaOutput).in_hours
		return diferencia
	end
end
