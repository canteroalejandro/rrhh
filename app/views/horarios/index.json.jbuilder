json.array!(@horarios) do |horario|
  json.extract! horario, :id, :codigo, :nombre, :diaInicio, :diaFin, :horaInicio, :horaFin
  json.url horario_url(horario, format: :json)
end
