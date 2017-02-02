module ContratoEmpleadosHelper


	def next_day(fecha)
		if fecha != nil
			fecha = fecha.advance(days: 1)
		else
			DateTime.now
		end
	end
	

end
