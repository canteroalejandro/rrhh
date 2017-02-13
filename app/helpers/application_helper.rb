module ApplicationHelper
  def is_active?(page_name)
    "active" if params[:controller] == page_name
  end

  def pluralize_without_count count, singular, plural=nil
    ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize))
  end

  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def date_server
    return DateTime.now.httpdate
  end

  def ldate(dt, hash = {})
    dt ? l(dt, hash) : nil
  end

  def human_boolean(boolean)
      boolean ? 'Si' : 'No'
  end

  # Metodo comun para los modelos: Empleado y Horarios
  # para el manejo del calendario.
  def detalles_for_calendar(horario)
    unless horario.kind_of? NilClass
      return horario.detalle_horarios.map do |det|
        aux = det.as_json
        aux[:nombre] = det.try(:proyecto).try(:nombre)
        aux
      end
    else
      return []
    end
  end
end
