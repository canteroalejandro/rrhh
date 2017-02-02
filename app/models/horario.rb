class Horario < ActiveRecord::Base

	has_many :horario_empleados
	has_many :empleados, through: :horario_empleados

	before_save do
	  self.dia.gsub!(/[\[\]\"]/, "") if attribute_present?("dia")
	end

	#format
	validates :codigo, :format => { :with => /(HR-)\d*/, :message => "El formato del Código es incorrecto" }
	#prescence
	validates :codigo, :nombre, presence: {message: "El campo %{attribute} debe ser completado"}

	def numeros_por_dias(nro)
		if nro == 0
			return "Lunes"
		elsif nro == 1
			return "Martes"
		elsif nro == 2
			return "Miércoles"
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

	def string_por_dias(texto)
		aux = texto.split(", ").map(&:to_i)
		texto = ""
		for a in aux do			
			texto = texto + numeros_por_dias(a)+ ", "
		end
		result = texto[0,texto.length-2]
		return result
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

	def getHorasDeTrabajo
		TimeDifference.between(horaEntrada, horaSalida).in_hours
	end

	def is_laboral_day?(fecha)
		texto = self.dia
		aux = texto.split(", ").map {|e| (e.to_i) +1 }
		aux.include? fecha.wday
	end

	def getInicialesDias
		dias_string = self.string_por_dias(self.dia)
		list_dias = dias_string.split(", ")
		list_dias = list_dias.map { |e| e[0..1] }
		list_dias.join(", ")
	end
end
