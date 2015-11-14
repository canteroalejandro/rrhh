class Categoria < ActiveRecord::Base
	has_many :empleados

	#format
	validates :codigo, :format => { :with => /(CA-)\d*/, :message => "El formato del Código es incorrecto" }
	#prescence
	validates :codigo, :nombre, presence: {message: "El campo %{attribute} debe ser completado"}
	validates :salarioBase, presence: {message: "El campo Salario Básico debe ser completado"}
	#uniqueness
	validates :codigo, uniqueness: { case_sensitive: false, message: "El %{attribute} ya existe"}
	validates :nombre, uniqueness: { :scope => :codigo, message: "El %{attribute} ya existe con éste Código"}

	def codigo_categoria
		if self.codigo == nil
			if Categoria.exists? == false
				categoria = 1
			else
				categoria = Categoria.last.id+1
			end
			while "#{categoria}".length < 5
				categoria = "0" + "#{categoria}"
			end
			return "CA-#{categoria}"
		else
			return self.codigo
		end
	end

end
