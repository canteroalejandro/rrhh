class ContratoEmpleado < ActiveRecord::Base
	belongs_to :empleado 
	belongs_to :contrato

	before_save :set_finalizacion
	after_save :update_antiguedad_empleado

	def get_nombre_empleado(emp)
		aux= Empleado.find(emp)
		return "#{aux.nombre} #{aux.apellido}"
	end

	def set_finalizacion
		aux= Contrato.find(self.contrato_id)
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

	def update_antiguedad_empleado
		empleado = Empleado.find(self.empleado_id)
		empleado.update("antiguedad" => empleado.set_antiguedad)
	end
end
