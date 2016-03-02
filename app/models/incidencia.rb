class Incidencia < ActiveRecord::Base
	has_many :incidencia_empleados
	has_many :empleados, through: :incidencia_empleados

	validates :codigo, :format => { :with => /(INC-)\d*/, :message => "El formato del Código es incorrecto" }

	def codigo_incidencia
		if self.codigo == nil
			if Incidencia.exists? == false
				incidencia = 1
			else
				incidencia = Incidencia.last.id+1
			end
			while "#{incidencia}".length < 5
				incidencia = "0" + "#{incidencia}"
			end
			return "INC-#{incidencia}"
		else
			return self.codigo
		end
	end

	def tiempos_array
		return ['días','semanas','meses','años']
	end
end
