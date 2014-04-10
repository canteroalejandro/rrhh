class Contador < ActiveRecord::Base
  attr_accessible :nombre

  belongs_to :localidad
  belongs_to :departamento
  belongs_to :provincia
  belongs_to :pais

  has_many :paquetes_de_servicios, :dependent => :restrict
  has_many :servicios, :dependent => :restrict
  has_many :servicios_prestados, :dependent => :restrict
  has_many :clientes, :dependent => :restrict

  validates :nro_documento, numericality: true
  validates_uniqueness_of :nro_documento, :scope => :tipo_documento_id
end
