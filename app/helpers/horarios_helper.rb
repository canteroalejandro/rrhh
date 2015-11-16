module HorariosHelper
	def checked(area)
	  @horario.dia.nil? ? false : @horario.dia.match(area)
	end

end
