class Horario < ActiveRecord::Base
	
	def numero_a_dia(dia)
		puts case dia
		when 0
			return "Domingo"
		when 1	
			return "Lunes"
		when 2
			return "Martes"
		when 3
			return "Miércoles"
		when 4
			return "Jueves"
		when 5
			return "Viernes"
		when 6	
			return "Sábado"
		end
	end

end
