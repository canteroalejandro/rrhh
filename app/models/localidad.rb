class Localidad < ActiveRecord::Base
  attr_accessible :nombre, :pais_id, :provincia_id, :departamento_id
  
  belongs_to :pais
  belongs_to :provincia
  belongs_to :departamento

  has_many :clientes, :dependent => :restrict
  has_many :contadores, :dependent => :restrict

  validates :nombre, :presence => true
end
