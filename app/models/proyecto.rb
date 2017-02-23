class Proyecto < ActiveRecord::Base
  belongs_to :departamento
  belongs_to :empleado
  has_many :empleado_proyectos , inverse_of: :proyecto, dependent: :destroy
  has_many :empleados, through: :empleado_proyectos

  has_many :detalle_horarios, dependent: :restrict_with_error

  #has_many :empleados, inverse_of: :proyecto
  #format
  validates :codigo, :format => { :with => /(PR-)\d*/, :message => "El formato del Código es incorrecto" }

  def codigo_proyecto
    if self.codigo == nil
      if Proyecto.exists? == false
        proyecto = 1
      else
        proyecto = Proyecto.last.id+1
      end
      while "#{proyecto}".length < 5
        proyecto = "0" + "#{proyecto}"
      end
      return "PR-#{proyecto}"
    else
      return self.codigo
    end
  end
end
