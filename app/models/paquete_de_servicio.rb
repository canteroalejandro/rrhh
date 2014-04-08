class PaqueteDeServicio < ActiveRecord::Base
  attr_accessible :activo, :descripcion, :monto

  belongs_to :contador
  belongs_to :cliente
  has_many :items_de_servicios

  validates_uniqueness_of :descripcion, :case_sensitive => false

  def self.paqueteDeServicioActivo(cliente_id)
    return PaqueteDeServicio.where(cliente_id: cliente_id).last
  end
end
