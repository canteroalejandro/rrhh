json.array!(@departamentos) do |departamento|
  json.extract! departamento, :id, :codigo, :nombre, :fechaEnQueDirige
  json.url departamento_url(departamento, format: :json)
end
