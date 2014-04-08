class TipoDocumentoComercial < ActiveRecord::Base
  attr_accessible :descripcion, :nombre

  has_many :movimientos, :dependent => :restrict

  validates :nombre, :presence => true
end
