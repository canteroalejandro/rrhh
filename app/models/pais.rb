class Pais < ActiveRecord::Base
  attr_accessible :nombre

  has_many :clientes, :dependent => :restrict
  has_many :contadors, :dependent => :restrict
  has_many :provincias
  has_many :departamentos
  has_many :localidades

  validates :nombre, :uniqueness => true
  validates :nombre, :presence => true
end
