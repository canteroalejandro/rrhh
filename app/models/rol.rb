class Rol < ActiveRecord::Base

  def self.crearAsistencia(empleado)

    ("2016-01-01 08:00 -03:00".to_datetime..Time.now.to_datetime).each do |fecha|
        # Crear el CheckIn

        if fecha.wday == 0 and rand(20) > 15
          next
        else

          @check_in = CheckIn.new({
            horaOutput: rand(20) > 15 ? fecha.change({min: rand(60) }) : fecha, 
            usuario_id: 1, 
            empleado_id: empleado
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
            break
          end

          @check_out = CheckOut.new({
            horaOutput: rand(20) > 15 ? fecha.change({hour: 12, min: rand(60) }) : fecha.change({hour: 12}), 
            usuario_id: 1, 
            empleado_id: empleado
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
            break
          end
        end
    end
  end
end
