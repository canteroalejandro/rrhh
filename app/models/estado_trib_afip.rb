class EstadoTribAfip < ActiveRecord::Base
  attr_accessible :clave, :condicion, :fechaAlta

  belongs_to :cliente
  belongs_to :categoria
end
