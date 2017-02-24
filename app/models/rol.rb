class Rol < ActiveRecord::Base

  def self.forAsistencias
    Usuario.all.each do |u| 
      if u.empleado.departamento_id != 8
        self.crearAsistencia(u.empleado.id, u.id, "08:00", 12)
        self.crearAsistencia(u.empleado.id, u.id, "17:00", 21)
      else
        self.crearAsistencia(u.empleado.id, u.id, "08:00", 10)
        self.crearAsistencia(u.empleado.id, u.id, "14:00", 16)
      end
    end
  end

  def self.crearAsistencia(empleado_id, usuario_id, hora_in, hora_out)

    ("2016-12-01 #{hora_in} -03:00".to_datetime..Time.now.to_datetime).each do |fecha|
        # Crear el CheckIn

        if fecha.wday == 0 and rand(20) > 15
          next
        else

          @check_in = CheckIn.new({
            horaOutput: rand(20) > 15 ? fecha.change({min: rand(60) }) : fecha.change({min: rand(14)}), 
            usuario_id: usuario_id, 
            empleado_id: empleado_id
          })

          if @check_in.save
            @asistencia = Asistencia.new
            @asistencia.entrada = true
            @asistencia.empleado_id = @check_in.empleado_id

            @asistencia.horario_id = @check_in.horario_id
            # @hor_emp = HorarioEmpleado.find(@check_in.horario_empleado_id)
            # @asistencia.horario_id = @hor_emp.horario_id
            @asistencia.check_in_id = @check_in.id
            @asistencia.save
          else
            puts "Check In: no guardo un carajo"
            @check_in.errors.full_messages.each do |message|
              puts message
            end
            # break
          end

          @check_out = CheckOut.new({
            horaOutput: rand(20) > 15 ? fecha.change({hour: hora_out, min: rand(60) }) : fecha.change({hour: hora_out, min: rand(14)}), 
            usuario_id: usuario_id, 
            empleado_id: empleado_id
          })

          # @check_out = CheckOut.new({horaOutput: fecha, usuario_id: 1, empleado_id: 1})
          # Crear el CheckOut
          if @check_out.save
            @check_out.asistencia.setHoraExtra
            @check_out.save
          else
            puts "Check Out: no guardo un carajo"
            puts "Errores: "
            @check_out.errors.full_messages.each do |message|
              puts message
            end
            # break
          end
        end
    end
  end
end
