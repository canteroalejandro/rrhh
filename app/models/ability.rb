class Ability < ActiveRecord::Base

  include CanCan::Ability

  def initialize(user)
  	user ||= Usuario.new

  	if user.rol? :Administrador
      can :read, :all
      can :manage, :all
    elsif user.rol? :Supervisor
      can :read, [Categoria, Empleado, Asistencia]
      can :manage, [CheckIn, CheckOut] 	
      can :manage, Proyecto, :departamento_id => user.empleado.departamento_id 
      can [:read, :ver_en_lista], Departamento, :id => user.empleado.departamento_id

    elsif user.rol? :Empleado
      can :manage, [CheckIn, CheckOut]
      can :read, [Asistencia]	
    end
  end
end
