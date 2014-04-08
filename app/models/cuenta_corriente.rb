class CuentaCorriente < ActiveRecord::Base
  attr_accessible :descripcion

  belongs_to :cliente
  has_many :movimientos, :dependent => :restrict
end
