class Cliente < ActiveRecord::Base
  attr_accessible :cbu, :claveAfip, :nombre, :nroCtaMunicipal

  belongs_to :contador
  belongs_to :actividad
  belongs_to :tipo_documento
  belongs_to :obra_social
  belongs_to :localidad
  belongs_to :departamento
  belongs_to :provincia
  belongs_to :pais
  has_one :cuenta_corriente
  has_many :estados_trib_afip, :dependent => :restrict
  has_many :paquetes_de_servicios, :dependent => :restrict
  has_many :imagenes, :dependent => :restrict
  has_many :servicios_prestados, :dependent => :restrict

  validates :tipo_documento_id, :nombre, :presence => true
  validates :nro_documento, numericality: true
  validates_uniqueness_of :nro_documento, :scope => :tipo_documento_id
end
