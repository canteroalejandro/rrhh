class Empleado < ActiveRecord::Base
	has_many :historia_medicas
	has_many :horarioEmpleados
	has_many :horarios, through: :horarioEmpleados
	has_one :categoria
	belongs_to :sexo
	belongs_to :categoria

	#format
	validates :codigo, :format => { :with => /(EMP-)\d*/, :message => "El formato del Código es incorrecto" }
	#validar presencia
	validates :apellido, :codigo, :nombre, presence: {message: "El campo %{attribute} debe ser completado"}
	validates :dni, presence: {message: "El campo DNI debe ser completado"}
	validates :direccion, presence: {message: "El campo Dirección debe ser completado"}
	#uniqueness
	validates :codigo, uniqueness: { case_sensitive: false, message: "El %{attribute} ya existe"}
	validates :dni, uniqueness: { case_sensitive: false, message: "El DNI ya existe"}

	def codigo_empleado
		if self.codigo == nil
			if Empleado.exists? == false
				empleado = 1
			else
				empleado = Empleado.last.id+1
			end
			while "#{empleado}".length < 5
				empleado = "0" + "#{empleado}"
			end
			return "EMP-#{empleado}"
		else
			return self.codigo
		end
	end

	def nombre_y_apellido
		return "#{nombre} #{apellido}"
	end
end
