class Departamento < ActiveRecord::Base
	has_many :empleados

	#format
	validates :codigo, :format => { :with => /(DPTO-)\d*/, :message => "El formato del Código es incorrecto" }
	#prescence
	validates :codigo, :nombre, presence: {message: "El campo %{attribute} debe ser completado"}
	#uniqueness
	validates :codigo, uniqueness: { case_sensitive: false, message: "El %{attribute} ya existe"}
	validates :nombre, uniqueness: { :scope => :codigo, message: "El %{attribute} ya existe con éste Código"}
	
	def codigo_departamento
		if self.codigo == nil
			if Departamento.exists? == false
				departamento = 1
			else
				departamento = Departamento.last.id+1
			end
			while "#{departamento}".length < 5
				departamento = "0" + "#{departamento}"
			end
			return "DPTO-#{departamento}"
		else
			return self.codigo
		end
	end
end
