class Movimiento < ActiveRecord::Base
  attr_accessible :bonifManual, :bonifPaqServ, :debe, :descripcion, :fecha, :haber, :nro_documento

  belongs_to :cuenta_corriente
  belongs_to :tipo_documento_comercial
  
  validates :fecha, :descripcion, :bonifManual, :bonifPaqServ, :debe, :haber, :presence => true
end
