rails g scaffold Categoria codigo:string nombre:string salarioBase:decimal

rails g scaffold Empleado codigo:string dni:string nombre:string apellido:string sexo:string fechaNacimiento:date direccion:string 

rails g scaffold Departamento codigo:string nombre:string fechaEnQueDirige:datetime

rails g scaffold Proyecto codigo:string nombre:string

rails g scaffold Horario codigo:string nombre:string dia:string horaEntrada:time horaSalida:time margenEntradaCheck:boolean margenSalidaCheck:boolean inicioMargenEntrada:time finMargenEntrada:time inicioMargenSalida:time finMargenSalida:time

rails g scaffold Usuario userName:string password:string rol:string

rails g scaffold Asistencia entrada:boolean salida:boolean outputAsistencia:string horasTrabajadas:decimal

rails g scaffold HistoriaMedica codigo:string fecha:date doctor:string

rails g scaffold Sexo codigo:string sexo:string

#crear una tabla con dias(de la semana), no un scaffold

# Model to Table, nombre del modelo sin camelcase
rails generate migration AddEmpleadoRefToHistoriaMedica empleado:references

rails generate migration AddEmpleadoRefToHorario empleado:references

rails generate migration AddEmpleadoRefToUsuario empleado:references

rails generate migration AddEmpleadoRefToAsistencia empleado:references

rails generate migration AddCategoriaRefToEmpleado categoria:references

rails generate migration AddDepartamentoRefToEmpleado departamento:references

rails generate migration AddDepartamentoRefToProyecto departamento:references