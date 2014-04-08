class Provincia < ActiveRecord::Base
  attr_accessible :nombre

  # belongs_to :pais
  has_many :clientes, :dependent => :restrict
  has_many :contadores, :dependent => :restrict

  validates :nombre, :presence => true
end
