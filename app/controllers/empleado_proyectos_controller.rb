class EmpleadoProyectosController < ApplicationController
	before_action :set_empleado_proyecto, only: [:show, :edit, :update, :destroy]
	load_and_authorize_resource
	  
	def index
		@empleado_proyectos = EmpleadoProyecto.all
	end

	  
	def show
	end

	def new
		@empleado_proyecto = EmpleadoProyecto.new
	end


	def edit
	end

	 
	def create
		@empleado_proyecto = EmpleadoProyecto.new(empleado_proyecto_params)

		respond_to do |format|
			if @empleado_proyecto.save
			  format.json { render :show, status: :created, location: @empleado_proyecto }
			else
			  format.json { render json: @empleado_proyecto.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
	   	if @empleado_proyecto.update(empleado_proyecto_params)
	     		format.json { render :show, status: :ok, location: @empleado_proyecto }
	   	else
	     		format.json { render json: @empleado_proyecto.errors, status: :unprocessable_entity }
	   	end
		end
	end

	  # DELETE /empleado_proyectos/1
	  # DELETE /empleado_proyectos/1.json
	def destroy
	   @empleado_proyecto.destroy
	   respond_to do |format|
	     format.json { head :no_content }
	   end
	end

	private
	    # Use callbacks to share common setup or constraints between actions.
	  def set_empleado_proyecto
	   @empleado_proyecto = EmpleadoProyecto.find(params[:id])
	  end

	    # Never trust parameters from the scary internet, only allow the white list through.
	  def empleado_proyecto_params
	   params.require(:empleado_proyecto).permit(:empleado_id, :proyecto_id)
	  end
end


