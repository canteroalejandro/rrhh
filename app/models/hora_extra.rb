class HoraExtra < ActiveRecord::Base

  #format
  validates :codigo, :format => { :with => /(H.EXT-)\d*/, :message => "El formato del Código es incorrecto" }
  #prescence
  validates :codigo, :nombre, presence: {message: "El campo %{attribute} debe ser completado"}

  before_save do
    self.dia.gsub!(/[\[\]\"]/, "") if attribute_present?("dia")
  end


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

  def codigo_hora_extra
    if self.codigo == nil
      if HoraExtra.exists? == false
        hora_extra = 1
      else
        hora_extra = HoraExtra.last.id+1
      end
      while "#{hora_extra}".length < 5
        hora_extra = "0" + "#{hora_extra}"
      end
      return "H.EXT-#{hora_extra}"
    else
      return self.codigo
    end
  end

  # Retorna que Tipo de Hora Extra corresponde segun fecha, hora_inicio, hora_fin
  def self.whichByFecha(unaFecha, hora_inicio, hora_fin)
    @horas_extras = self.all
    day_integer = if unaFecha.wday == 0 then 6 else unaFecha.wday - 1 end
    @horas_extras.select do |he|
      if he.dia.split(", ").include? (day_integer).to_s        
        h_inicio = he.horaInicio.strftime("%X") < hora_inicio.strftime("%X")
        h_fin = he.horaFin.strftime("%X") > hora_fin.strftime("%X")
        if h_inicio and h_fin
          return he
        end
      end
    end
  end
end
