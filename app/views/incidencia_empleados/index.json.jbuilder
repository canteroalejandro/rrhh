json.array!(@incidencia_empleados) do |incidencia_empleado|
  json.extract! incidencia_empleado, :id, :inicio
  json.url incidencia_empleado_url(incidencia_empleado, format: :json)
end
