json.array!(@sexos) do |sexo|
  json.extract! sexo, :id, :codigo, :sexo
  json.url sexo_url(sexo, format: :json)
end
