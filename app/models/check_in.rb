class CheckIn < ActiveRecord::Base

  has_one :asistencia, dependent: :destroy
  has_one :check_out, dependent: :destroy
  
  # belongs_to :horario_empleado 
  # has_one :horario, through: :horario_empleado
  
  belongs_to :horario

  belongs_to :usuario 
  belongs_to :empleado 

  before_validation :set_horario

  validate :hay_incidencia
  validate :tiene_horario?
  validate :tiene_contrato_vigente

  before_save :set_tardanza

  def get_empleado(user)
    aux= Empleado.find(user.empleado_id)
    return "#{aux.nombre} #{aux.apellido}"
  end

  def get_usuario
    return self.current_user.id
  end

  def set_horario
    self.horario = empleado.horarios.last
  end

  def hay_incidencia
    incidencia_asociada = IncidenciaEmpleado.where(empleado_id: self.empleado_id)
    for i in incidencia_asociada
      if (self.horaOutput > i.inicio) and (self.horaOutput < i.fin)
        errors.add(:base, "El empleado se encuentra temporalmente inhabilitado para registrar asistencias. Ver Incidencias asociadas al Empleado")
      end
    end
  end

  def tiene_horario?  
    if self.horario.kind_of? NilClass
      errors.add(:base, "El empleado No posee un horario asignado para realizar el Check-In.")
    end
  end

  def tiene_contrato_vigente
    if not self.empleado.tiene_contrato_vigente(self.horaOutput)
      errors.add(:base, "El empleado No posee un contrato vigente para realizar un Check-In.")
    end
  end

  def set_tardanza
    self.tardanza = false
    horario = empleado.horarios.last
    
    horario.get_detalle_horarios_by_day(self.horaOutput).each do |det_horario|
      if self.horaOutput.strftime("%H%M%S%N") >= det_horario.horaEntrada.strftime("%H%M%S%N") and det_horario.horaSalida.strftime("%H%M%S%N") >= self.horaOutput.strftime("%H%M%S%N")
        
        h_entrada_margen = det_horario.horario.finMargenEntrada.hour
        m_entrada_margen = det_horario.horario.finMargenEntrada.min
        hora_entrada_c_margen = (det_horario.horaEntrada + (h_entrada_margen).hour) + (m_entrada_margen).minutes

        if self.horaOutput.strftime("%H%M%S%N") > hora_entrada_c_margen.strftime("%H%M%S%N")
          self.tardanza = true
          break
        end
      end
    end
  end
end
