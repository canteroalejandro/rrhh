class SessionsController < ApplicationController

	def new
	end

	def create
	  user = Usuario.authenticate(params[:userName], params[:password])
	  if user
	    session[:usuario_id] = user.id
	    redirect_to new_asistencia_path, :notice => "Logged in!"
	  else
	    flash.now.alert = "Invalid email or password"
	    render "new"
	  end
	end

	def destroy
	  session[:usuario_id] = nil
	  redirect_to log_in_path, :notice => "Logged out!"
	end

end
