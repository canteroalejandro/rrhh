class ObraSocial < ActiveRecord::Base
  attr_accessible :detalle, :nombre

  has_many :clientes, :dependent => :restrict
  
  validates :acronimo, :uniqueness => true
  validates :acronimo, :nombre, :presence => true
end
