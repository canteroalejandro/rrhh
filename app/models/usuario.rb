class Usuario < ActiveRecord::Base

  belongs_to :rol
  belongs_to :empleado

  has_many :asistencias, dependent: :restrict_with_error 
  has_many :check_ins, dependent: :restrict_with_error 

  validates :userName, uniqueness: { case_sensitive: false, message: "El Nombre de usuario ya existe"}
	validates :empleado_id, uniqueness: { case_sensitive: false, message: "El Empleado Seleccionado ya posee una Cuenta de Usuario."}

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
