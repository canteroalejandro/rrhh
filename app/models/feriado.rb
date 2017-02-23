class Feriado < ActiveRecord::Base
  validates :fecha, uniqueness: { message: "Ya existe un feriado con la fecha seleccionada."}

  validates_format_of :descripcion, :with => /\A[0-9]+-[-a-z0-9]+/i, message: "No puede estar en blanco."


  def self.is_feriado?(unaFecha)
    feriado = self.where(fecha: unaFecha).first
    not feriado.kind_of? NilClass
  end
end
