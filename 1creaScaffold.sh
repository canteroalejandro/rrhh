rails g scaffold Categoria codigo:string nombre:string salarioBase:decimal

rails g scaffold Empleado codigo:string dni:string nombre:string apellido:string sexo:string fechaNacimiento:date direccion:string 

rails g scaffold Departamento codigo:string nombre:string fechaEnQueDirige:datetime

rails g scaffold Proyecto codigo:string nombre:string

rails g scaffold Horario codigo:string nombre:string dia:string horaEntrada:time horaSalida:time margenEntradaCheck:boolean margenSalidaCheck:boolean inicioMargenEntrada:time finMargenEntrada:time inicioMargenSalida:time finMargenSalida:time

rails g scaffold Usuario userName:string password:string rol:string

rails g scaffold Asistencia entrada:boolean salida:boolean outputAsistencia:string horasTrabajadas:decimal

rails g scaffold HistoriaMedica codigo:string fecha:date doctor:string

rails g scaffold CheckIn tardanza:boolean horaOutput:datetime

rails g scaffold CheckOut horaOutput:datetime

rails g scaffold HoraExtra codigo:string nombre:string dia:string horaInicio:time horaFin:time precio:float

rails g scaffold Incidencia codigo:string nombre:string nroDuracion:integer tiempoDuracion:string tieneCondiciones:boolean fechaInicioHabilitacion:date fechaFinHabilitacion:date nroAntiguedadMayor:integer tiempoAntiguedadMayor:string nroAntiguedadMenor:integer tiempoAntiguedadMenor:string vecesPermitidasPorAño:integer

# Model to Table, nombre del modelo sin camelcase
rails generate migration AddEmpleadoRefToHistoriaMedica empleado:references

rails generate migration AddEmpleadoRefToHorario empleado:references

rails generate migration AddEmpleadoRefToUsuario empleado:references

rails generate migration AddEmpleadoRefToAsistencia empleado:references

rails generate migration AddEmpleadoRefToDepartamento empleado:references

rails generate migration AddCategoriaRefToEmpleado categoria:references

rails generate migration AddDepartamentoRefToEmpleado departamento:references

rails generate migration AddDepartamentoRefToProyecto departamento:references
rails generate migration AddEmpleadoRefToProyecto empelado:references

rails generate migration AddHorarioRefToAsistencia horario:references

rails generate migration AddUsuarioRefToAsistencia usuario:references

rails generate migration AddHorarioRefToHorarioEmpleado horario:references
rails generate migration AddEmpleadoRefToHorarioEmpleado empleado:references

rails generate migration AddHorarioEmpleadoRefToCheckIn horario_empleado:references
rails generate migration AddHorarioEmpleadoRefToCheckOut horario_empleado:references

rails generate migration AddUsuarioRefToCheckIn usuario:references
rails generate migration AddUsuarioRefToCheckOut usuario:references

rails generate migration AddEmpleadoRefToCheckIn empleado:references
rails generate migration AddEmpleadoRefToCheckOut empleado:references

rails generate migration AddCheckInRefToCheckOut check_in:references

rails generate migration AddRolRefToUsuario rol:references

rails generate migration AddCheckInRefToAsistencia check_in:references
rails generate migration AddCheckOutRefToAsistencia check_out:references

rails generate migration AddDepartamentoRefToEmpleado departamento:references

rails generate migration AddProyectoRefToCheckOut proyecto:references

rails generate migration AddProyectoRefToEmpleado proyecto:references

#rails generate migration AddProyectoRefToEmpleadoProyecto proyecto:references
#rails generate migration AddEmpleadoRefToEmpleadoProyecto empleado:references

#FOREIGN KEY

rails generate migration AddSupervisorIdToDepartamento supervisor_id:integer