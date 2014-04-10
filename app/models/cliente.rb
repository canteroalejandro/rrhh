class Cliente < ActiveRecord::Base
  attr_accessible :cbu, :claveAfip, :nombre, :nroCtaMunicipal, :estadoTribAfipActual
  attr_accessible :pais_id, :provincia_id, :departamento_id, :localidad_id
  attr_accessible :contador_id

  belongs_to :contador
  belongs_to :actividad
  belongs_to :obra_social
  belongs_to :localidad
  belongs_to :departamento
  belongs_to :provincia
  belongs_to :pais
  has_one :cuenta_corriente
  has_many :estados_trib_afip, :dependent => :restrict
  has_many :paquetes_de_servicios, :dependent => :restrict
  has_many :imagenes, :dependent => :restrict
  has_many :servicios_realizados, :dependent => :restrict

  validates :nombre, :contador, :presence => true
  validates :pais, :provincia, :departamento, :localidad, :presence => true
  # validates :tipo_documento_id, :presence => true
  # validates :nro_documento, numericality: true
  # validates_uniqueness_of :nro_documento, :scope => :tipo_documento_id
end
