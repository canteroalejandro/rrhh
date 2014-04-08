class ServicioRealizado < ActiveRecord::Base
  attr_accessible :bonificacion, :descripcion, :fecha, :monto

  belongs_to :contador
  belongs_to :cliente
  belongs_to :servicio

  validates :descripcion, :bonificacion, :fecha, :monto, :contador, :servicio, :presence => true
end
