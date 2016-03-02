json.array!(@contratos) do |contrato|
  json.extract! contrato, :id, :codigo, :nombre, :nroDuracion, :tiempoDuracion, :horasDia, :edadMinima
  json.url contrato_url(contrato, format: :json)
end
