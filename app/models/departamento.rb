class Departamento < ActiveRecord::Base
  attr_accessible :nombre, :pais_id, :provincia_id

  belongs_to :pais
  belongs_to :provincia
  has_many :localidades
  has_many :clientes, :dependent => :restrict
  has_many :contadores, :dependent => :restrict

  validates :nombre, :presence => true
end
