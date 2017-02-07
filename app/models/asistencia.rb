class Asistencia < ActiveRecord::Base

  belongs_to :empleado
  
  belongs_to :check_in
  has_one :horario, through: :check_in
  belongs_to :hora_extra

  belongs_to :check_out
  has_one :proyecto, through: :check_out

  def setHoraExtra
    if is_horas_extra? # Aca tiene que mandar el horario de entrada del check in
      he = nil
      if Feriado.is_feriado? check_out.horaOutput.to_date
        he = HoraExtra.find Setting.feriado_id
      else
        he = HoraExtra.whichByFecha(
          check_out.horaOutput.to_date, 
          check_out.horaOutput - getHorasExtras.hours,
          check_out.horaOutput
        )
      end
      update_attribute(:hora_extra, he)
    end
  end
  
  def set_salida_en_pantalla
    check_in = CheckIn.find(self.check_in_id)
    check_out = CheckOut.find(self.check_out_id)
    return"Entrada: #{check_in.horaOutput.strftime("%e/%m/%y %H:%M")} - Salida: #{check_out.horaOutput.strftime("%e/%m/%y %H:%M")}"   
  end

  def calcular_horas_trabajadas
    check_in = CheckIn.find(self.check_in_id)
    check_out = CheckOut.find(self.check_out_id)
    diferencia = TimeDifference.between(check_in.horaOutput, check_out.horaOutput).in_hours
    return diferencia
  end

  def is_horas_extra?(fecha)
    # Hora Extra es cuando supera los limites horarios con margenes incluidos
    calcular_horas_trabajadas > horario.getHorasDeTrabajo(fecha)
    # if check_in.horaOutput - 

    # check_out
  end

  def getHorasExtras
    if calcular_horas_trabajadas > horario.getHorasDeTrabajo
      return calcular_horas_trabajadas - horario.getHorasDeTrabajo
    else
      return 0
    end
  end
end
