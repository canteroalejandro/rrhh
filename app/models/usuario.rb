class Usuario < ActiveRecord::Base

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
end
