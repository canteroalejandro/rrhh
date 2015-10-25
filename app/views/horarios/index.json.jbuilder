json.array!(@horarios) do |horario|
  json.extract! horario, :id, :codigo, :nombre, :horaEntrada, :horaSalida, :margenEntradaCheck, :margenSalidaCheck, :inicioMargenEntrada, :finMargenEntrada, :inicioMargenSalida, :finMargenSalida
  json.url horario_url(horario, format: :json)
end
