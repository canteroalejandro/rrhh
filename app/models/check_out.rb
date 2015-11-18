class CheckOut < ActiveRecord::Base
	belongs_to :horario_empleado 
	belongs_to :usuario 
end
