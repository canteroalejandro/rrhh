class Empleado < ActiveRecord::Base
  include VerificationAssociations

  has_many :asistencias
  has_many :historia_medicas
  has_many :horarioEmpleados
  has_many :horarios, through: :horarioEmpleados
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
          created_at: unaFecha.beginning_of_month..unaFecha.end_of_month,
          proyectos: { id: unProyecto})
    else
      retorno = asistencias.joins(:proyecto)
        .where(created_at: unaFecha.beginning_of_month..unaFecha.end_of_month)
    end
    return retorno
  end

  def asistencias_by_hora_extra(unaFecha, unaHoraExtra)
    retorno = nil
    retorno = asistencias.joins(:hora_extra)
      .where(
        created_at: unaFecha.beginning_of_month..unaFecha.end_of_month,
        hora_extra: unaHoraExtra
      )
    return retorno
  end
end
