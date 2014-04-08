class Categoria < ActiveRecord::Base
  attr_accessible :fechaVigencia, :gastosMaxLuz, :identificador, :montoMaxFacturado

  has_many :estados_trib_afip, :dependent => :restrict

  validates :identificador, :uniqueness => true
  validates :identificador, :fechaVigencia, :presence => true
end
