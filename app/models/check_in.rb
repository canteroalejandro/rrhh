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
    # self.tardanza = false
    # hor_emp = HorarioEmpleado.find(self.horario_empleado_id)
    # aux= Horario.find(hor_emp.horario_id)
    
    # if (self.horaOutput.strftime("%H%M%S%N") > aux.finMargenEntrada.strftime("%H%M%S%N"))
    #   self.tardanza = true
    # end
  end
end
