class Ability < ActiveRecord::Base

  include CanCan::Ability

  def initialize(user)
  	user ||= Usuario.new

  	if user.rol? :Administrador
      can :read, :all
      can :manage, :all
    elsif user.rol? :Supervisor
      can :read, [Categoria, Departamento, Empleado, Asistencia]
      can :manage, [CheckIn, CheckOut] 	
    elsif user.rol? :Empleado
      can :manage, [CheckIn, CheckOut]
      can :read, [Asistencia]	
    end
  end
end
