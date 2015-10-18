json.array!(@usuarios) do |usuario|
  json.extract! usuario, :id, :userName, :password, :rol
  json.url usuario_url(usuario, format: :json)
end
