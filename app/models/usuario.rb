class Usuario < ActiveRecord::Base

  def self.authenticate(username, password)
    user = Usuario.where(userName: username).first
    if user && user.password == password
      user
    else
      nil
    end
  end
end
