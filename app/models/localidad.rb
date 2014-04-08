class Localidad < ActiveRecord::Base
  attr_accessible :nombre
  
  has_many :clientes, :dependent => :restrict
  has_many :contadores, :dependent => :restrict

  validates :nombre, :presence => true
end
