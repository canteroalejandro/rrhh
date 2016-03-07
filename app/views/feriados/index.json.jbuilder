json.array!(@feriados) do |feriado|
  json.extract! feriado, :id, :descripcion, :fecha
  json.url feriado_url(feriado, format: :json)
end
