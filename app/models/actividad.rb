class Actividad < ActiveRecord::Base
  attr_accessible :codigo, :descripcion

  has_many :clientes, :dependent => :restrict
  
  validates :codigo, :uniqueness => true
  validates :codigo, :descripcion, :presence => true
end
