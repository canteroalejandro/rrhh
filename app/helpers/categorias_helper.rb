module CategoriasHelper

	def get_agrup_render(nombre_str)
		nombre_str.slice(0, nombre_str.length - 5)
	end

	def get_categ_render(codigo_str)
		codigo_str.slice(codigo_str.length - 1, codigo_str.length)
	end
end