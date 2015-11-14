class Sexo < ActiveRecord::Base
	validates :sexo, presence: {message: "El campo debe ser completado"}
	validates :sexo, uniqueness: { case_sensitive: false, message: "El tipo de sexo ya existe"}
end
