class CheckIn < ActiveRecord::Base
	belongs_to :horario_empleado 
	belongs_to :usuario 

	def get_horario

	end

	def get_empleado

	end
end
