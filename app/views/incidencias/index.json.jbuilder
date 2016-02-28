json.array!(@incidencias) do |incidencia|
  json.extract! incidencia, :id, :codigo, :nombre, :nroDuracion, :tiempoDuracion, :tieneCondiciones, :fechaInicioHabilitacion, :fechaFinHabilitacion, :nroAntiguedadMayor, :tiempoAntiguedadMayor, :nroAntiguedadMenor, :tiempoAntiguedadMenor, :vecesPermitidasPorAño
  json.url incidencia_url(incidencia, format: :json)
end
