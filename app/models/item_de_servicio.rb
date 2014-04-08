class ItemDeServicio < ActiveRecord::Base
  attr_accessible :monto_establecido

  belongs_to :paquete_de_servicio
  belongs_to :servicio
  
  validates :monto_establecido, :servicio, :presence => true
end
