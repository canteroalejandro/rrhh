class Asistencia < ActiveRecord::Base

  belongs_to :empleado
  
  belongs_to :check_in
  has_one :horario, through: :check_in
  belongs_to :hora_extra

  belongs_to :check_out

  def setHoraExtra
    if Feriado.is_feriado? check_out.horaOutput.to_date
      he = HoraExtra.find Setting.feriado_id
      update_attribute(:hora_extra, he)
    elsif is_horas_extra?(check_in, check_out)
      he = HoraExtra.whichByFecha(
        check_out.horaOutput.to_date, 
        check_out.horaOutput - getHorasExtras(check_in, check_out),
        check_out.horaOutput)
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

  def is_horas_extra?(check_in_date, check_out_date)
    det_horarios = horario.get_horarios_correspondientes(check_in_date, check_out_date)
    # Calculo la cantidad de horas de los detalles de horarios.
    if det_horarios.length > 0
      horas_proyectos = det_horarios.map { |e| TimeDifference.between(e.horaEntrada, e.horaSalida).in_hours }.reduce(:+)
    else
      horas_proyectos = 0
    end
    calcular_horas_trabajadas >= (horas_proyectos + 1)
   end

  def getHorasExtras(check_in_date, check_out_date)
    if Feriado.is_feriado? check_in_date.horaOutput.to_date
      return calcular_horas_trabajadas
    elsif calcular_horas_trabajadas >= (horario.getHorasDeTrabajoAsignado(check_in_date, check_out_date) + 1)
      return calcular_horas_trabajadas - horario.getHorasDeTrabajoAsignado(check_in_date, check_out_date)
    else
      return 0
    end
  end

  def trabajo_en_este_proyecto?(proyecto_id)
    det_horarios = horario.get_horarios_correspondientes(check_in, check_out)
    det_horarios.select {|dh| dh.proyecto_id == proyecto_id}.length > 0
  end

  def get_detalle_horario(proyecto_id)
    det_horarios = horario.get_horarios_correspondientes(check_in, check_out)
    det_horarios.select {|dh| dh.proyecto_id == proyecto_id}
  end
end
