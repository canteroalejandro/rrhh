json.array!(@asistencias) do |asistencia|
  json.extract! asistencia, :id, :entrada, :salida
  json.url asistencia_url(asistencia, format: :json)
end
