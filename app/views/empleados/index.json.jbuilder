json.array!(@empleados) do |empleado|
  json.extract! empleado, :id, :codigo, :dni, :nombre, :apellido, :sexo, :fechaNacimiento, :direccion
  json.url empleado_url(empleado, format: :json)
end
