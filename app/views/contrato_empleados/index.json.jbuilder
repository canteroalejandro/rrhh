json.array!(@contrato_empleados) do |contrato_empleado|
  json.extract! contrato_empleado, :id, :inicio
  json.url contrato_empleado_url(contrato_empleado, format: :json)
end
