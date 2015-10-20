rails g scaffold Categoria codigo:string nombre:string salarioBase:decimal

rails g scaffold Empleado codigo:string dni:string nombre:string apellido:string sexo:string fechaNacimiento:date direccion:string 

rails g scaffold Departamento codigo:string nombre:string fechaEnQueDirige:datetime

rails g scaffold Proyecto codigo:string nombre:string

rails g scaffold Horario codigo:string nombre:string diaInicio:integer diaFin:integer horaInicio:time horaFin:time

rails g scaffold Usuario userName:string password:string rol:string

rails g scaffold Asistencia entrada:boolean salida:boolean outputAsistencia:string