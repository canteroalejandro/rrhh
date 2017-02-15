class Horario < ActiveRecord::Base

  has_many :horario_empleados
  # has_many :empleados, through: :horario_empleados
  belongs_to :empleado

  has_many :detalle_horarios

  accepts_nested_attributes_for :detalle_horarios

  before_save do
    self.dia.gsub!(/[\[\]\"]/, "") if attribute_present?("dia")
  end

  #format
  # validates :codigo, :format => { :with => /(HR-)\d*/, :message => "El formato del Código es incorrecto" }
  validate :empleado_id, :presence
  #prescence
  # validates :codigo, :nombre, presence: {message: "El campo %{attribute} debe ser completado"}

  def numeros_por_dias(nro)
    if nro == 0
      return "Lunes"
    elsif nro == 1
      return "Martes"
    elsif nro == 2
      return "Miércoles"
    elsif nro == 3
      return "Jueves"
    elsif nro == 4
      return "Viernes"
    elsif nro == 5
      return "Sábado"
    elsif nro == 6
      return "Domingo"
    end 
  end

  def string_por_dias(texto)
    aux = texto.split(", ").map(&:to_i)
    texto = ""
    for a in aux do     
      texto = texto + numeros_por_dias(a)+ ", "
    end
    result = texto[0,texto.length-2]
    return result
  end

  def codigo_horario
    if self.codigo == nil
      if Horario.exists? == false
        horario = 1
      else
        horario = Horario.last.id+1
      end
      while "#{horario}".length < 5
        horario = "0" + "#{horario}"
      end
      return "HR-#{horario}"
    else
      return self.codigo
    end
  end

  def is_laboral_day?(fecha)
    texto = self.dia
    aux = texto.split(", ").map {|e| (e.to_i) +1 }
    aux.include? fecha.wday
  end

  def getInicialesDias
    dias_string = self.string_por_dias(self.dia)
    list_dias = dias_string.split(", ")
    list_dias = list_dias.map { |e| e[0..1] }
    list_dias.join(", ")
  end

  # Retorna los detalles de horario (proyectos).
  # Que deberia haber cumplido el empleado, segun su horario asignado.
  def get_horarios_correspondientes(check_in, check_out)
    day_integer = 0
    if check_in.horaOutput.wday == 0
      day_integer = 6
    else
      day_integer = check_in.horaOutput.wday - 1
    end
    detalles = detalle_horarios.select {|dh| dh.dia == day_integer }
    
    detalles = detalles.sort_by {|e| e.horaEntrada }

    detalles.select do |dh|
    
      h_entrada_margen = dh.horario.inicioMargenEntrada.hour
      m_entrada_margen = dh.horario.inicioMargenEntrada.min
      hora_entrada_c_margen = (dh.horaEntrada - (h_entrada_margen).hour) - (m_entrada_margen).minutes

      h_salida_margen = dh.horario.inicioMargenSalida.hour
      m_salida_margen = dh.horario.inicioMargenSalida.min
      hora_salida_c_margen = (dh.horaSalida + (h_salida_margen).hour) + (m_salida_margen).minutes

      check_in_normalizado = check_in.horaOutput.clone
      check_in_normalizado = check_in_normalizado
        .change(year: dh.horaEntrada.year, 
          month: dh.horaEntrada.month,
          day: dh.horaEntrada.day)

      check_out_normalizado = check_out.horaOutput.clone
      check_out_normalizado = check_out_normalizado
        .change(year: dh.horaEntrada.year, 
          month: dh.horaEntrada.month,
          day: dh.horaEntrada.day)

      # Comprueba que el ingreso sea dentro de este horario.
      if  check_in_normalizado >= hora_entrada_c_margen
        # Compruebo que el empleado entro a trabajar en este detalle de horario.
        if check_in_normalizado <= hora_salida_c_margen
          # Compruebo si continuo trabajando en otro horario, o realizo Horas Extras en su defecto.
          if check_out_normalizado > hora_salida_c_margen
            true
          # Sino el empleado salio dentro de este horario.
          else
            true
          end
        end
      # El empleado entro antes trabajar.
      else
        # Comprueba si el empleado finalizo su jornada en este detalle de horario.
        if (check_out_normalizado <= hora_salida_c_margen) and (check_out_normalizado >= hora_entrada_c_margen)
          true
        # El Empleado continuo trabajando.
        else
          # Comprobar si trabajo mas de 1 hora, para que entre como hora extra.
          if (hora_salida_c_margen + 1.hours) <= check_out_normalizado
            #hizo horas extras.
            true
          end
        end
      end
    end
  end

  # Retorna el total de horas correspondientes al "turno" que el empleado deberia haber cumplido
  # Segun el check-in y check-out
  def getHorasDeTrabajoAsignado(check_in, check_out)
    det_horarios = get_horarios_correspondientes(check_in, check_out)
    if det_horarios.length > 0
      det_horarios.map { |e| TimeDifference.between(e.horaEntrada, e.horaSalida).in_hours }.reduce(:+)
    else 
      0
    end
  end

  def get_detalle_horarios_by_day(fecha)
    day_integer = 0
    if fecha.wday == 0
      day_integer = 6
    else
      day_integer = fecha.wday - 1
    end
    detalle_horarios.select {|dh| dh.dia == day_integer }
  end
end
