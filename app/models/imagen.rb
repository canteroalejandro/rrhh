class Imagen < ActiveRecord::Base
  attr_accessible :fecha, :nombre, :url_imagen

  belongs_to :cliente
  
  validates :nombre, :fecha, :url_imagen, :presence => true
end
