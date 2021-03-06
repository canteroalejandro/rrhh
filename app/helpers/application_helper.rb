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

  ##########################################################
  # Metodos comunes para los modelos: Empleado y Horarios  #
  # para el manejo del calendario.                         #
  ##########################################################
  def detalles_for_calendar(horario)
    unless horario.kind_of? NilClass
      return horario.detalle_horarios.map do |det|
        aux = det.as_json
        aux[:nombre] = det.try(:proyecto).try(:nombre)
        aux[:codigo_proyecto] = det.try(:proyecto).try(:codigo)
        aux
      end
    else
      return []
    end
  end

  def reset_queue(cola)
    cola.push("success")
    cola.push("danger")
    cola.push("purple")
    cola.push("yellow")
    cola.push("pink")
    cola.push("info")
    cola.push("grey")
  end

  def genLabels(proyectos)
    cola = Queue.new
    reset_queue(cola)
    
    hash_color = {}
    unless proyectos.kind_of? NilClass
      proyectos.each do |proy|
        if cola.blank?
          reset_queue(cola)
          hash_color[proy.id] = cola.pop
        else
          hash_color[proy.id] = cola.pop
        end
      end
      return hash_color
    else
      return hash_color
    end
  end
end
