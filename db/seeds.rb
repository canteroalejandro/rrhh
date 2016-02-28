Categoria.create!([
  {codigo: "CA-00001", nombre: "Gerente de Departamento", salarioBase: "41236.0"},
  {codigo: "CA-00002", nombre: "Jefe de Proyecto", salarioBase: "20124.0"},
  {codigo: "CA-00003", nombre: "Analista Senior", salarioBase: "19786.0"},
  {codigo: "CA-00004", nombre: "Analista Junior", salarioBase: "12057.0"}
])

Empleado.create!([
  {codigo: "EMP-00001", dni: "33958772", nombre: "Berta", apellido: "Rivera", fechaNacimiento: "1989-04-11", direccion: "Leandro Gomez 5886", categoria_id: 1 },
  {codigo: "EMP-00005", dni: "30444512", nombre: "Juliana", apellido: "Castiglione", fechaNacimiento: "1980-12-09", direccion: "Brisas 3280", categoria_id: 3 },
  {codigo: "EMP-00007", dni: "36063876", nombre: "Lara", apellido: "Riveros", fechaNacimiento: "1991-10-22", direccion: "Colon 123", categoria_id: 4 },
  {codigo: "EMP-00004", dni: "25221305", nombre: "Pablo", apellido: "Gomez", fechaNacimiento: "1970-03-05", direccion: "Neruda 7393", categoria_id: 2 },
  {codigo: "EMP-00006", dni: "35421824", nombre: "Ignacio", apellido: "Marino", fechaNacimiento: "1991-06-24", direccion: "Bajada Vieja 844", categoria_id: 4 },
  {codigo: "EMP-00008", dni: "38994567", nombre: "Matilde", apellido: "Santos", fechaNacimiento: "1994-08-08", direccion: "Ombu 4942", categoria_id: 4 },
  {codigo: "EMP-00009", dni: "35666222", nombre: "Luis", apellido: "Ribeiro", fechaNacimiento: "1990-01-03", direccion: "Colombia 2351", categoria_id: 3 },
  {codigo: "EMP-00002", dni: "19423568", nombre: "Nahuel", apellido: "Estevez", fechaNacimiento: "1966-11-28", direccion: "Av. Alta Gracia 5332", categoria_id: 1 },
  {codigo: "EMP-00003", dni: "25334991", nombre: "Hilda", apellido: "Zielinski", fechaNacimiento: "1970-04-07", direccion: "Joaquin Suarez 6863", categoria_id: 2 }
])

Horario.create!([
  {codigo: "HR-00001", nombre: "Mañana", dia: "0, 1, 2, 3, 4", horaEntrada: "2000-01-01 08:00:00", horaSalida: "2000-01-01 12:00:00", margenEntradaCheck: true, margenSalidaCheck: true, inicioMargenEntrada: "2000-01-01 07:50:00", finMargenEntrada: "2000-01-01 08:10:00", inicioMargenSalida: "2000-01-01 12:00:00", finMargenSalida: "2000-01-01 12:15:00", empleado_id: nil},
  {codigo: "HR-00002", nombre: "Tarde", dia: "0, 1, 2, 3, 4", horaEntrada: "2000-01-01 16:00:00", horaSalida: "2000-01-01 20:00:00", margenEntradaCheck: true, margenSalidaCheck: true, inicioMargenEntrada: "2000-01-01 15:50:00", finMargenEntrada: "2000-01-01 16:10:00", inicioMargenSalida: "2000-01-01 20:00:00", finMargenSalida: "2000-01-01 20:15:00", empleado_id: nil}
])

HorarioEmpleado.create!([
  {fechaInicio: "2015-07-01", horario_id: 1, empleado_id: 1},
  {fechaInicio: "2015-11-17", horario_id: 2, empleado_id: 1},
  {fechaInicio: "2015-09-01", horario_id: 1, empleado_id: 2},
  {fechaInicio: "2015-09-01", horario_id: 2, empleado_id: 2}
])

Rol.create!([
  {nombre: "Administrador"},
  {nombre: "Supervisor"},
  {nombre: "Empleado"}
])

Usuario.create!([
  {userName: "EMP-00001", password: "NONE", empleado_id: 1, rol_id: 1},
  {userName: "EMP-00002", password: "NONE", empleado_id: 2, rol_id: 2},
  {userName: "EMP-00003", password: "NONE", empleado_id: 3, rol_id: 3}
])

# Departamento.create!([
#   {codigo: "DPTO-00001", nombre: "Compras", fechaEnQueDirige: "2016-02-05", empleado_id: nil, supervisor_id: 1},
#   {codigo: "DPTO-00002", nombre: "Producción", fechaEnQueDirige: "2016-02-05", empleado_id: nil, supervisor_id: 4},
#   {codigo: "DPTO-00003", nombre: "Finanzas", fechaEnQueDirige: "2016-02-05", empleado_id: nil, supervisor_id: 9}
# ])

# Empleado.update!([
#   {empleado_id:1, departamento_id: 1},
#   {empleado_id:2, departamento_id: 1},
#   {empleado_id:3, departamento_id: 1},
#   {empleado_id:4, departamento_id: 2},
#   {empleado_id:5, departamento_id: 2},
#   {empleado_id:6, departamento_id: 2},
#   {empleado_id:7, departamento_id: 3},
#   {empleado_id:8, departamento_id: 3},
#   {empleado_id:9, departamento_id: 3}
# ])
#---------------------------------------------------------------------------
