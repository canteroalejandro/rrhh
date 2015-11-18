rails g scaffold Categoria codigo:string nombre:string salarioBase:decimal

rails g scaffold Empleado codigo:string dni:string nombre:string apellido:string sexo:string fechaNacimiento:date direccion:string 

rails g scaffold Departamento codigo:string nombre:string fechaEnQueDirige:datetime

rails g scaffold Proyecto codigo:string nombre:string

rails g scaffold Horario codigo:string nombre:string dia:string horaEntrada:time horaSalida:time margenEntradaCheck:boolean margenSalidaCheck:boolean inicioMargenEntrada:time finMargenEntrada:time inicioMargenSalida:time finMargenSalida:time

rails g scaffold Usuario userName:string password:string rol:string

rails g scaffold Asistencia entrada:boolean salida:boolean outputAsistencia:string horasTrabajadas:decimal

rails g scaffold HistoriaMedica codigo:string fecha:date doctor:string

rails g scaffold Sexo sexo:string

rails g scaffold CheckIn tardanza:boolean horaOutput:datetime

rails g scaffold CheckOut horaOutput:datetime

# Model to Table, nombre del modelo sin camelcase
rails generate migration AddEmpleadoRefToHistoriaMedica empleado:references

rails generate migration AddEmpleadoRefToHorario empleado:references

rails generate migration AddEmpleadoRefToUsuario empleado:references

rails generate migration AddEmpleadoRefToAsistencia empleado:references

rails generate migration AddEmpleadoRefToDepartamento empleado:references

rails generate migration AddCategoriaRefToEmpleado categoria:references

rails generate migration AddDepartamentoRefToEmpleado departamento:references

rails generate migration AddDepartamentoRefToProyecto departamento:references

rails generate migration AddSexoRefToEmpleado sexo:references

rails generate migration AddHorarioRefToAsistencia horario:references

rails generate migration AddUsuarioRefToAsistencia usuario:references

rails generate migration AddHorarioRefToHorarioEmpleado horario:references
rails generate migration AddEmpleadoRefToHorarioEmpleado empleado:references

rails generate migration AddHorarioEmpleadoRefToCheckIn horario_empleado:references
rails generate migration AddHorarioEmpleadoRefToCheckOut horario_empleado:references

rails generate migration AddUsuarioRefToCheckIn usuario:references
rails generate migration AddUsuarioRefToCheckOut usuario:references