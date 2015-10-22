json.array!(@historia_medicas) do |historia_medica|
  json.extract! historia_medica, :id, :codigo, :fecha, :doctor
  json.url historia_medica_url(historia_medica, format: :json)
end
