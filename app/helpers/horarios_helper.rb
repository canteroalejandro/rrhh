module HorariosHelper
    def checked(area)
      @horario.dia.nil? ? false : @horario.dia.match(area)
    end

    def reset_queue(cola)
        cola.push("success")
            .push("danger")
            .push("purple")
            .push("yellow")
            .push("pink")
            .push("info")
            .push("grey")
    end

    def get_color_label(cola)
        if cola.blank?
            reset_queue(cola)
            cola.pop
        else
            cola.pop
        end
    end
end
