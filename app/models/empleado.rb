class Empleado < ActiveRecord::Base
  include VerificationAssociations

  has_many :asistencias
  has_many :check_ins
  has_many :check_outs
  has_many :historia_medicas
  
  # has_many :horarioEmpleados
  has_many :horarios

  has_one :categoria
  belongs_to :departamento
  has_many :empleado_proyectos
  has_many :proyectos, through: :empleado_proyectos
  belongs_to :categoria

  has_many :incidencia_empleados
  has_many :incidencias, through: :incidencia_empleados

  has_many :contrato_empleados
  has_many :contratos, through: :contrato_empleados

  #has_one :encargado, :class_name => "Empleado", :foreign_key => "encargado_id"

  #format
  validates :codigo, :format => { :with => /(EMP-)\d*/, :message => "El formato del Código es incorrecto" }
  #validar presencia
  validates :apellido, :codigo, :nombre, presence: {message: "El campo %{attribute} debe ser completado"}
  validates :dni, presence: {message: "El campo DNI debe ser completado"}
  validates :direccion, presence: {message: "El campo Dirección debe ser completado"}
  #uniqueness
  validates :codigo, uniqueness: { case_sensitive: false, message: "El %{attribute} ya existe"}
  validates :dni, uniqueness: { case_sensitive: false, message: "El DNI ya existe"}

  def codigo_empleado
    if self.codigo == nil
      if Empleado.exists? == false
        empleado = 1
      else
        empleado = Empleado.last.id+1
      end
      while "#{empleado}".length < 5
        empleado = "0" + "#{empleado}"
      end
      return "EMP-#{empleado}"
    else
      return self.codigo
    end
  end

  def nombre_y_apellido
    return "#{nombre} #{apellido}"
  end

  #earliest = Model.first(:order => 'column asc')

  def get_antiguedad
    if self.contrato_empleados.exists?
      contratos = self.contrato_empleados.all
      duracion_contratos = 0
      for c in contratos do
        if(c.fin < Time.now)
          duracion_contratos = duracion_contratos + TimeDifference.between(c.inicio, c.fin).in_years
        else
          duracion_contratos = duracion_contratos + TimeDifference.between(c.inicio, Time.now).in_years
        end
      end
      antiguedad = duracion_contratos.to_i
    else
      antiguedad = 0
    end
    return antiguedad
  end

  def set_antiguedad
    if self.contrato_empleados.exists?
      contratos = self.contrato_empleados.all
      duracion_contratos = 0
      for c in contratos do
        if(c.fin < Time.now)
          duracion_contratos = duracion_contratos + TimeDifference.between(c.inicio, c.fin).in_years
        else
          duracion_contratos = duracion_contratos + TimeDifference.between(c.inicio, Time.now).in_years
        end
      end
      antiguedad = duracion_contratos.to_i
    else
      antiguedad = 0
    end
    return antiguedad
  end

  def asistencias_by_mes_and_project(unaFecha, unProyecto)
    retorno = nil
    if unProyecto != "all"
      retorno = asistencias.joins(:proyecto)
        .where(
          check_outs: { horaOutput: unaFecha.beginning_of_month..unaFecha.end_of_month },
          proyectos: { id: unProyecto})

        # created_at: unaFecha.beginning_of_month..unaFecha.end_of_month,
        # .joins(:check_outs).where(check_outs:{ horaOutput: "07/03/2016 00:00"to_datetime.."12/03/2016 23:59".to_datetime})
    else
      retorno = asistencias.joins(:proyecto)
        .where(check_outs: { horaOutput: unaFecha.beginning_of_month..unaFecha.end_of_month })
    end
    return retorno
  end

  def asistencias_by_hora_extra(unaFecha, unaHoraExtra)
    retorno = nil
    retorno = asistencias.joins(:hora_extra, :check_out)
      .where(
        check_outs:{ horaOutput: unaFecha.beginning_of_month..unaFecha.end_of_month},
        hora_extra: unaHoraExtra
      )
    return retorno
  end

  def has_check_in?(unaFecha, unHorario)
    hora_inicio = (unaFecha.to_time).change(
      { 
        hour: unHorario.horaEntrada.hour, 
        min: unHorario.horaEntrada.min, 
        sec: unHorario.horaEntrada.sec
      })
    
    hora_salida = (unaFecha.to_time).change(
      { 
        hour: unHorario.horaSalida.hour, 
        min: unHorario.horaSalida.min, 
        sec: unHorario.horaSalida.sec
      })

    ret = CheckIn.where horaOutput: hora_inicio..hora_salida, empleado_id: self.id
    ret.size > 0
  end

  def has_incidencia?(fecha)
    incidencia_asociada = IncidenciaEmpleado.where(empleado_id: self.id)
    indicencias = []
    incidencia_asociada.each do |incidencia|
      if incidencia.inicio >= fecha and incidencia.fin >= fecha
        indicencias.push incidencia
      end
    end
    indicencias.size > 0
  end

  def getCantInasistencias(unaFechaInicio, unaFechaFin)
    inasistencias = 0
    # Itera sobre una coleccion de Fechas
    (unaFechaInicio..unaFechaFin).each do |fecha|
      # Por cada fecha, consulta los horarios de trabajo del empleado.
      self.horarios.each do |horario|
        # Si tiene Check-In se descarta, pues fue al lugar de trabajo
        if not self.has_check_in? fecha, horario
          # Comprueba si el dia de ausencia es un dia laboral dentro de su horario
          if horario.is_laboral_day?(fecha)
            # Comprueba si el dia de ausencia es un Feriado
            if not Feriado.is_feriado?(fecha)
              # Comprueba que no tenga incidencias en esa fecha
              if not has_incidencia? fecha
                inasistencias += 1
              end
            end
          end
        end

      end
    end
    inasistencias
  end

  def self.empleadosDelDepartamento(departamento_id)
    if not departamento_id == nil
      self.where departamento: departamento_id
    else
      return []
    end
  end

  def self.empleadosSinDptoAsignado
    self.where departamento: nil
  end

  def vinculo_actual
    self.contrato_empleados.last
  end

  def tiene_contrato_vigente(fecha)
    if vinculo_actual.fin >= fecha then
      return true
    else
      return false
    end
  end
end
