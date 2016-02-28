class Usuario < ActiveRecord::Base

  belongs_to :rol
  belongs_to :empleado
  #uniqueness
	validates :userName, uniqueness: { case_sensitive: false, message: "El Nombre de usuario ya existe"}

  def self.authenticate(username, password)
    user = Usuario.where(userName: username).first
    if user && user.password == password
      user
    else
      nil
    end
  end

  def rol?(role_sym)
    self.rol.nombre.to_sym == role_sym
  end
end
