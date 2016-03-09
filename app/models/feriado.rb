class Feriado < ActiveRecord::Base
	def self.is_feriado?(unaFecha)
		feriado = self.where(fecha: unaFecha).first
		not feriado.kind_of? NilClass
	end
end
