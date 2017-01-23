class Rol < ActiveRecord::Base

  # def self.crearAsistencia

  #   check_ins = [
  #     {horaOutput: "2016-03-09 08:05:00", horario_empleado_id: 1, usuario_id: 1, empleado_id: 1},
  #     {horaOutput: "2016-03-07 08:05:00", horario_empleado_id: 1, usuario_id: 1, empleado_id: 1},
  #     {horaOutput: "2016-03-09 07:06:00", horario_empleado_id: 1, usuario_id: 1, empleado_id: 1},
  #     {horaOutput: "2016-03-07 06:52:00", horario_empleado_id: 1, usuario_id: 1, empleado_id: 1},
  #     {horaOutput: "2016-03-07 07:04:00", horario_empleado_id: 1, usuario_id: 1, empleado_id: 1},
  #     {horaOutput: "2016-03-07 07:01:00", horario_empleado_id: 1, usuario_id: 1, empleado_id: 1},
  #     {horaOutput: "2016-03-07 08:03:00", horario_empleado_id: 3, usuario_id: 4, empleado_id: 2},
  #     {horaOutput: "2016-03-08 08:30:00", horario_empleado_id: 3, usuario_id: 4, empleado_id: 2},
  #     {horaOutput: "2016-03-08 16:02:00", horario_empleado_id: 4, usuario_id: 4, empleado_id: 2},
  #     {horaOutput: "2016-03-09 08:05:00", horario_empleado_id: 3, usuario_id: 4, empleado_id: 2},
  #     {horaOutput: "2016-03-09 15:50:00", horario_empleado_id: 4, usuario_id: 4, empleado_id: 2},
  #     {horaOutput: "2016-03-07 08:33:00", horario_empleado_id: 9, usuario_id: 4, empleado_id: 8},
  #     {horaOutput: "2016-03-10 08:02:00", horario_empleado_id: 9, usuario_id: 4, empleado_id: 8},
  #     {horaOutput: "2016-03-10 16:04:00", horario_empleado_id: 10, usuario_id: 4, empleado_id: 8},
  #     {horaOutput: "2016-03-07 16:04:00", horario_empleado_id: 10, usuario_id: 4, empleado_id: 8},
  #     {horaOutput: "2016-03-11 08:08:00", horario_empleado_id: 9, usuario_id: 4, empleado_id: 8},
  #     {horaOutput: "2016-03-11 16:16:00", horario_empleado_id: 10, usuario_id: 4, empleado_id: 8},
  #     {horaOutput: "2016-03-07 08:05:00", horario_empleado_id: 11, usuario_id: 4, empleado_id: 9},
  #     {horaOutput: "2016-03-07 16:08:00", horario_empleado_id: 12, usuario_id: 4, empleado_id: 9},
  #     {horaOutput: "2016-03-08 08:00:00", horario_empleado_id: 11, usuario_id: 4, empleado_id: 9},
  #     {horaOutput: "2016-03-08 16:04:00", horario_empleado_id: 12, usuario_id: 4, empleado_id: 9},
  #     {horaOutput: "2016-03-07 08:00:00", horario_empleado_id: 13, usuario_id: 4, empleado_id: 4},
  #     {horaOutput: "2016-03-07 16:27:00", horario_empleado_id: 14, usuario_id: 4, empleado_id: 4},
  #     {horaOutput: "2016-03-08 08:16:00", horario_empleado_id: 13, usuario_id: 4, empleado_id: 4},
  #     {horaOutput: "2016-03-08 16:07:00", horario_empleado_id: 14, usuario_id: 4, empleado_id: 4},
  #     {horaOutput: "2016-03-07 08:25:00", horario_empleado_id: 15, usuario_id: 4, empleado_id: 5},
  #     {horaOutput: "2016-03-08 08:10:00", horario_empleado_id: 15, usuario_id: 4, empleado_id: 5},
  #     {horaOutput: "2016-03-10 08:06:00", horario_empleado_id: 15, usuario_id: 4, empleado_id: 5},
  #     {horaOutput: "2016-03-11 08:12:00", horario_empleado_id: 15, usuario_id: 4, empleado_id: 5},
  #     {horaOutput: "2016-03-07 08:00:00", horario_empleado_id: 16, usuario_id: 4, empleado_id: 3},
  #     {horaOutput: "2016-03-09 08:06:00", horario_empleado_id: 16, usuario_id: 4, empleado_id: 3},
  #     {horaOutput: "2016-03-07 08:13:00", horario_empleado_id: 17, usuario_id: 4, empleado_id: 6},
  #     {horaOutput: "2016-03-08 08:14:00", horario_empleado_id: 17, usuario_id: 4, empleado_id: 6},
  #     {horaOutput: "2016-03-09 08:09:00", horario_empleado_id: 17, usuario_id: 4, empleado_id: 6},
  #     {horaOutput: "2016-03-07 08:17:00", horario_empleado_id: 18, usuario_id: 4, empleado_id: 7},
  #     {horaOutput: "2016-03-08 08:16:00", horario_empleado_id: 18, usuario_id: 4, empleado_id: 7},
  #     {horaOutput: "2016-03-07 17:06:00", horario_empleado_id: 19, usuario_id: 4, empleado_id: 7}
  #   ]

  #   check_outs = [
  #     {horaOutput: "2016-03-09 18:00:00".to_time - 3.hours, horario_empleado_id: 1, usuario_id: 1, empleado_id: 1, empleado_proyecto_id: 1},
  #     {horaOutput: "2016-03-07 17:30:00".to_time - 3.hours, horario_empleado_id: 1, usuario_id: 1, empleado_id: 1, empleado_proyecto_id: 1},
  #     {horaOutput: "2016-03-09 18:02:00".to_time - 3.hours, horario_empleado_id: 1, usuario_id: 1, empleado_id: 1, empleado_proyecto_id: 1},
  #     {horaOutput: "2016-03-07 17:52:00".to_time - 3.hours, horario_empleado_id: 1, usuario_id: 1, empleado_id: 1, empleado_proyecto_id: 1},
  #     {horaOutput: "2016-03-09 18:00:00".to_time - 3.hours, horario_empleado_id: 1, usuario_id: 1, empleado_id: 1, empleado_proyecto_id: 1},
  #     {horaOutput: "2016-03-07 18:03:00".to_time - 3.hours, horario_empleado_id: 1, usuario_id: 1, empleado_id: 1, empleado_proyecto_id: 1},
  #     {horaOutput: "2016-03-07 16:10:00".to_time - 3.hours, horario_empleado_id: 3, usuario_id: 4, empleado_id: 2, empleado_proyecto_id: 2},
  #     {horaOutput: "2016-03-08 14:50:00".to_time - 3.hours, horario_empleado_id: 3, usuario_id: 4, empleado_id: 2, empleado_proyecto_id: 2},
  #     {horaOutput: "2016-03-08 23:30:00".to_time - 3.hours, horario_empleado_id: 4, usuario_id: 4, empleado_id: 2, empleado_proyecto_id: 2},
  #     {horaOutput: "2016-03-09 16:16:00".to_time - 3.hours, horario_empleado_id: 3, usuario_id: 4, empleado_id: 2, empleado_proyecto_id: 2},
  #     {horaOutput: "2016-03-09 23:10:00".to_time - 3.hours, horario_empleado_id: 4, usuario_id: 4, empleado_id: 2, empleado_proyecto_id: 2},
  #     {horaOutput: "2016-03-07 15:30:00".to_time - 3.hours, horario_empleado_id: 9, usuario_id: 4, empleado_id: 8, empleado_proyecto_id: 6},
  #     {horaOutput: "2016-03-10 15:31:00".to_time - 3.hours, horario_empleado_id: 9, usuario_id: 4, empleado_id: 8, empleado_proyecto_id: 6},
  #     {horaOutput: "2016-03-10 23:30:00".to_time - 3.hours, horario_empleado_id: 10, usuario_id: 4, empleado_id: 8, empleado_proyecto_id: 6},
  #     {horaOutput: "2016-03-07 22:57:00".to_time - 3.hours, horario_empleado_id: 10, usuario_id: 4, empleado_id: 8, empleado_proyecto_id: 6},
  #     {horaOutput: "2016-03-11 15:17:00".to_time - 3.hours, horario_empleado_id: 9, usuario_id: 4, empleado_id: 8, empleado_proyecto_id: 6},
  #     {horaOutput: "2016-03-11 23:03:00".to_time - 3.hours, horario_empleado_id: 10, usuario_id: 4, empleado_id: 8, empleado_proyecto_id: 6},
  #     {horaOutput: "2016-03-07 15:06:00".to_time - 3.hours, horario_empleado_id: 11, usuario_id: 4, empleado_id: 9, empleado_proyecto_id: 7},
  #     {horaOutput: "2016-03-07 22:58:00".to_time - 3.hours, horario_empleado_id: 12, usuario_id: 4, empleado_id: 9, empleado_proyecto_id: 7},
  #     {horaOutput: "2016-03-08 15:18:00".to_time - 3.hours, horario_empleado_id: 11, usuario_id: 4, empleado_id: 9, empleado_proyecto_id: 7},
  #     {horaOutput: "2016-03-08 23:13:00".to_time - 3.hours, horario_empleado_id: 12, usuario_id: 4, empleado_id: 9, empleado_proyecto_id: 7},
  #     {horaOutput: "2016-03-07 16:00:00".to_time - 3.hours, horario_empleado_id: 13, usuario_id: 4, empleado_id: 4, empleado_proyecto_id: 9},
  #     {horaOutput: "2016-03-07 23:48:00".to_time - 3.hours, horario_empleado_id: 14, usuario_id: 4, empleado_id: 4, empleado_proyecto_id: 9},
  #     {horaOutput: "2016-03-08 15:38:00".to_time - 3.hours, horario_empleado_id: 13, usuario_id: 4, empleado_id: 4, empleado_proyecto_id: 9},
  #     {horaOutput: "2016-03-08 23:13:00".to_time - 3.hours, horario_empleado_id: 14, usuario_id: 4, empleado_id: 4, empleado_proyecto_id: 9},
  #     {horaOutput: "2016-03-07 15:42:00".to_time - 3.hours, horario_empleado_id: 15, usuario_id: 4, empleado_id: 5, empleado_proyecto_id: 10},
  #     {horaOutput: "2016-03-08 15:16:00".to_time - 3.hours, horario_empleado_id: 15, usuario_id: 4, empleado_id: 5, empleado_proyecto_id: 10},
  #     {horaOutput: "2016-03-10 15:14:00".to_time - 3.hours, horario_empleado_id: 15, usuario_id: 4, empleado_id: 5, empleado_proyecto_id: 10},
  #     {horaOutput: "2016-03-11 15:17:00".to_time - 3.hours, horario_empleado_id: 15, usuario_id: 4, empleado_id: 5, empleado_proyecto_id: 10},
  #     {horaOutput: "2016-03-07 15:03:00".to_time - 3.hours, horario_empleado_id: 16, usuario_id: 4, empleado_id: 3, empleado_proyecto_id: 4},
  #     {horaOutput: "2016-03-09 16:14:00".to_time - 3.hours, horario_empleado_id: 16, usuario_id: 4, empleado_id: 3, empleado_proyecto_id: 4},
  #     {horaOutput: "2016-03-07 15:12:00".to_time - 3.hours, horario_empleado_id: 17, usuario_id: 4, empleado_id: 6, empleado_proyecto_id: 8},
  #     {horaOutput: "2016-03-08 15:35:00".to_time - 3.hours, horario_empleado_id: 17, usuario_id: 4, empleado_id: 6, empleado_proyecto_id: 8},
  #     {horaOutput: "2016-03-09 15:31:00".to_time - 3.hours, horario_empleado_id: 17, usuario_id: 4, empleado_id: 6, empleado_proyecto_id: 8},
  #     {horaOutput: "2016-03-07 15:17:00".to_time - 3.hours, horario_empleado_id: 18, usuario_id: 4, empleado_id: 7, empleado_proyecto_id: 5},
  #     {horaOutput: "2016-03-08 15:29:00".to_time - 3.hours, horario_empleado_id: 18, usuario_id: 4, empleado_id: 7, empleado_proyecto_id: 5},
  #     {horaOutput: "2016-03-08 00:16:00".to_time - 3.hours, horario_empleado_id: 19, usuario_id: 4, empleado_id: 7, empleado_proyecto_id: 5}
  #   ]

  #   for i in(0..check_ins.size)
  #       # Crear el CheckIn
  #       @check_in = CheckIn.new(check_ins[i])

  #       if @check_in.save
  #         @asistencia = Asistencia.new
  #         @asistencia.entrada = true
  #         @asistencia.empleado_id = @check_in.empleado_id
  #         @hor_emp = HorarioEmpleado.find(@check_in.horario_empleado_id)
  #         @asistencia.horario_id = @hor_emp.horario_id
  #         @asistencia.check_in_id = @check_in.id
  #         @asistencia.save
  #       else
  #         puts "Check In: no guardo un carajo"
  #         break
  #       end

  #       @check_out = CheckOut.new(check_outs[i])
  #       # Crear el CheckOut
  #       if @check_out.save
  #         @check_out.asistencia.setHoraExtra
  #         @check_out.save
  #       else
  #         puts "Check Out: no guardo un carajo"
  #         puts "Errores: "
  #         @check_out.errors.full_messages.each do |message|
  #           puts message
  #         end
  #         break
  #       end
  #   end
  # end
end
