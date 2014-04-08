class Pais < ActiveRecord::Base
  attr_accessible :nombre

  has_many :clientes, :dependent => :restrict
  has_many :contadors, :dependent => :restrict
  # has_many :provincias

  validates :nombre, :uniqueness => true
  validates :nombre, :presence => true
end
