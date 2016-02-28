json.array!(@hora_extras) do |hora_extra|
  json.extract! hora_extra, :id, :codigo, :nombre, :dia, :horaInicio, :horaFin, :precio
  json.url hora_extra_url(hora_extra, format: :json)
end
