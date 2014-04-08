class Servicio < ActiveRecord::Base
  attr_accessible :descripcion, :monto

  belongs_to :contador
  
  def self.serviciosByContador(contador_id)
    return Servicio.where(contador_id: contador_id)
  end
end
