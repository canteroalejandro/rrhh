class Contrato < ActiveRecord::Base
	has_many :contrato_empleados
	has_many :empleados, through: :contrato_empleados

	validates :codigo, :format => { :with => /(CONT-)\d*/, :message => "El formato del Código es incorrecto" }

	def codigo_contrato
		if self.codigo == nil
			if Contrato.exists? == false
				contrato = 1
			else
				contrato = Contrato.last.id+1
			end
			while "#{contrato}".length < 5
				contrato = "0" + "#{contrato}"
			end
			return "CONT-#{contrato}"
		else
			return self.codigo
		end
	end

	def tiempos_array
		return ['días','semanas','meses','años']
	end
end
