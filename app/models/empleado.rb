class Empleado < ActiveRecord::Base
	has_many :historia_medicas
end
