class DetalleHorario < ActiveRecord::Base
  belongs_to :horario
  belongs_to :proyecto  
end
