module AsistenciasHelper

  def calcular_horas_trabajadas_en_proyecto(check_in_date, check_out_date, det_horario)
    check_in_normalizado = check_in_date.clone
    check_in_normalizado = check_in_normalizado
      .change(year: det_horario.horaEntrada.year, 
        month: det_horario.horaEntrada.month,
        day: det_horario.horaEntrada.day)

    check_out_normalizado = check_out_date.clone
    check_out_normalizado = check_out_normalizado
      .change(year: det_horario.horaEntrada.year, 
        month: det_horario.horaEntrada.month,
        day: det_horario.horaEntrada.day)

    # Comprueba que el ingreso sea dentro de este horario.
    if  check_in_normalizado >= det_horario.horaEntrada
      # Compruebo si salio antes de terminar del proyecto
      if check_out_normalizado <= det_horario.horaSalida
        [Time.at(TimeDifference.between(det_horario.horaEntrada, det_horario.horaSalida).in_seconds).utc.strftime("%H:%M"), 
          TimeDifference.between(det_horario.horaEntrada, det_horario.horaSalida).in_seconds]
      else
        # Entro en el horario, pero salio despues
        [Time.at(TimeDifference.between(check_in_normalizado, det_horario.horaSalida).in_seconds).utc.strftime("%H:%M"),
          TimeDifference.between(check_in_normalizado, det_horario.horaSalida).in_seconds]
      end
    # El empleado entro antes trabajar.
    else
      # Comprueba si el empleado finalizo su jornada en este detalle de horario.
      if (check_out_normalizado <= det_horario.horaSalida) and (check_out_normalizado >= det_horario.horaEntrada)
        [Time.at(TimeDifference.between(det_horario.horaEntrada, check_out_normalizado).in_seconds).utc.strftime("%H:%M"),
          TimeDifference.between(det_horario.horaEntrada, check_out_normalizado).in_seconds]
      else
        [Time.at(TimeDifference.between(det_horario.horaEntrada, det_horario.horaSalida).in_seconds).utc.strftime("%H:%M"),
          TimeDifference.between(det_horario.horaEntrada, det_horario.horaSalida).in_seconds]
      end
    end
  end
end