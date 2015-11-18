json.array!(@horario_empleados) do |horario_empleado|
  json.extract! horario_empleado, :id
  json.url horario_empleado_url(horario_empleado, format: :json)
end
