json.array!(@categorias) do |categoria|
  json.extract! categoria, :id, :codigo, :nombre, :salarioBase
  json.url categoria_url(categoria, format: :json)
end
