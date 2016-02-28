class Empleado < ActiveRecord::Base
	include VerificationAssociations

	has_many :asistencias
	has_many :historia_medicas
	has_many :horarioEmpleados
	has_many :horarios, through: :horarioEmpleados
	has_one :categoria
	belongs_to :departamento
	has_many :empleado_proyectos
	has_many :proyectos, through: :empleado_proyectos
	belongs_to :categoria

	#has_one :encargado, :class_name => "Empleado", :foreign_key => "encargado_id"

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
