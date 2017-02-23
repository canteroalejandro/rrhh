class ContratoEmpleado < ActiveRecord::Base
  belongs_to :empleado 
  belongs_to :contrato

  before_save :set_finalizacion
  after_save :update_antiguedad_empleado

  validate :es_compatible_el_contrato?
  validate :otro_contrato_en_fecha_seleccionada?

  def get_nombre_empleado(emp)
    aux= Empleado.find(emp)
    return "#{aux.nombre} #{aux.apellido}"
  end

  def get_fecha_fin(contrato)
    if contrato.tiempoDuracion == "días"
      self.inicio.advance(days: contrato.nroDuracion)
    elsif contrato.tiempoDuracion == "semanas"
      self.inicio.advance(weeks: contrato.nroDuracion)
    elsif contrato.tiempoDuracion == "meses"
      self.inicio.advance(months: contrato.nroDuracion)
    elsif contrato.tiempoDuracion == "años"
      self.inicio.advance(years: contrato.nroDuracion)
    end
  end

  def set_finalizacion
    aux= Contrato.find(self.contrato_id)
    self.fin = get_fecha_fin(aux)
  end

  def update_antiguedad_empleado
    empleado = Empleado.find(self.empleado_id)
    empleado.update("antiguedad" => empleado.set_antiguedad)
  end

  def es_compatible_el_contrato?
    empleado = Empleado.find(self.empleado_id)

    if empleado.contrato_empleados.exists?
      ultimo_vinculo = empleado.contrato_empleados.last
      # Verifica si el empleado tenia un contrato de Prueba
      if ultimo_vinculo.contrato.renovable == false
        if ultimo_vinculo.contrato.nroDuracion != 0
          if contrato == ultimo_vinculo.contrato
            # Este es el mismo contato anterior y no es Renovable.
            errors.add :base, "No es posible asignar el mismo contrato a este Empleado.\
              El Periodo de Prueba no es posible Renovarlo.\
              L.C.T. Ley Nro 20.744 Rep. Arg."
          end
        else
          # Es un Contrato Indeterminado
          # Los contratos indeterminados no pueden ser reemplazados por otros.
          # El empleado solamente puede ser desafectado de su cargo.
          errors.add :base, "No es posible asignar otro contrato a este Empleado\
            este tiene un contrato por tiempo indetrerminado.\
            L.C.T. Ley Nro 20.744 Rep. Arg."
        end
      # Verifica si se desea asignar un contrato renovable (Plazo Fijo)
      elsif contrato.renovable
        if empleado.get_antiguedad > 5
          # No se puede realizar un contrato renovable con este empleado
          # porque exede los 5 años de antiguedad.
          errors.add :base, "No es posible asignar otro contrato a este Empleado\
            este tiene un contrato por tiempo indetrerminado.\
            L.C.T. Ley Nro 20.744 Rep. Arg."
        end
      # En este caso: tenia un contrato Renovable (Probablemente Plazo Fijo)
      # Y quiere asignar un contrato No  Renovable (para Periodo de Prueba). ESTO NO SE PUEDE
      elsif contrato.nombre.upcase.include? "PRUEBA"
        errors.add :base, "No es posible asignar este contrato a este Empleado.\
          El Periodo de Prueba no es posible Renovarlo.\
          L.C.T. Ley Nro 20.744 Rep. Arg."
      end
    end
  end

  def otro_contrato_en_fecha_seleccionada?
    empleado.vinculos.each do |vinculo|
      if not vinculo.contrato.indeterminado
        if vinculo.inicio <= inicio and inicio <= vinculo.fin
          errors.add :base, "Este Contrato no puede ser Asignado en la fecha seleccionada.\
            Existe otro Contrato con fecha: \
            desde: #{I18n.localize vinculo.inicio} Hasta: #{I18n.localize vinculo.fin}."
        elsif inicio <=  vinculo.inicio and vinculo.fin <= get_fecha_fin(self.contrato)
          errors.add :base, "Este Contrato no puede tener la duracion seleccionada.\
            Existe otro Contrato con fecha: \
            desde: #{I18n.localize vinculo.inicio} Hasta: #{I18n.localize vinculo.fin}."
        end
      elsif (inicio < vinculo.inicio) and (get_fecha_fin(self.contrato) < vinculo.inicio)
        errors.add :base, "Este Empleado Tiene un Contrato por tiempo indeterminado a partir de la fecha:\
          #{I18n.localize vinculo.inicio}.\
          Ningun contato de Plazo Fijo puede ser Asignado despues de la Fecha.\nL.C.T. Ley Nro 20.744 Rep. Arg."
      end
    end
  end

  HUMANIZED_ATTRIBUTES = {
    :contrato_empleados => "Vinculos Contrato-Empleado"
  }

  def self.human_attribute_name(*args)
    HUMANIZED_ATTRIBUTES[args[0]] || super
  end
end