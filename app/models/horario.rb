class Horario < ActiveRecord::Base

	before_save do
	  self.dia.gsub!(/[\[\]\"]/, "") if attribute_present?("dia")
	end

	#format
	#validates :codigo, :format => { :with => /(HR-)\d*/, :message => "El formato del Código es incorrecto" }

	def numeros_por_dias(nro)
		if nro == 0
			return "Lunes"
		elsif nro == 1
			return "Martes"
		elsif nro == 2
			return "Miercoles"
		elsif nro == 3
			return "Jueves"
		elsif nro == 4
			return "Viernes"
		elsif nro == 5
			return "Sábado"
		elsif nro == 6
			return "Domingo"
		end	
	end

	def codigo_horario
		if self.codigo == nil
			if Horario.exists? == false
				horario = 1
			else
				horario = Horario.last.id+1
			end
			while "#{horario}".length < 5
				horario = "0" + "#{horario}"
			end
			return "HR-#{horario}"
		else
			return self.codigo
		end
	end

	
end
