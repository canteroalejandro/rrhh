Categoria.create!([
  {codigo: "CA-00001", nombre: "Administrativo", salarioBase: "18000.0"},
  {codigo: "CA-00002", nombre: "Maestranza", salarioBase: "17000.0"},
  {codigo: "CA-00003", nombre: "Cajero", salarioBase: "16000.0"},
  {codigo: "CA-00004", nombre: "Vendedor", salarioBase: "14000.0"},
  {codigo: "CA-00005", nombre: "Administrador BD", salarioBase: "15000.0"}
])

Contrato.create!([
  {codigo: "CONT-00001", nombre: "Contrato 5 años", nroDuracion: 5, tiempoDuracion: "años", horasDia: 8, edadMinima: 18},
  {codigo: "CONT-00002", nombre: "Contrato 10 años", nroDuracion: 10, tiempoDuracion: "años", horasDia: 8, edadMinima: 18},
  {codigo: "CONT-00003", nombre: "Contrato 15 años", nroDuracion: 15, tiempoDuracion: "años", horasDia: 8, edadMinima: 18},
  {codigo: "CONT-00004", nombre: "Contrato 20 años", nroDuracion: 20, tiempoDuracion: "años", horasDia: 8, edadMinima: 18},
  {codigo: "CONT-00005", nombre: "Contrato 25 años", nroDuracion: 25, tiempoDuracion: "años", horasDia: 8, edadMinima: 18},
  {codigo: "CONT-00006", nombre: "Contrato 30 años", nroDuracion: 30, tiempoDuracion: "años", horasDia: 8, edadMinima: 18},
  {codigo: "CONT-00007", nombre: "Periodo de Prueba", nroDuracion: 3, tiempoDuracion: "meses", horasDia: 4, edadMinima: 18},
  {codigo: "CONT-00008", nombre: "Contrato 2010", nroDuracion: 1, tiempoDuracion: "años", horasDia: 8, edadMinima: 18},
  {codigo: "CONT-00009", nombre: "Contrato 2011", nroDuracion: 1, tiempoDuracion: "años", horasDia: 8, edadMinima: 18},
  {codigo: "CONT-00010", nombre: "Contrato 2012", nroDuracion: 1, tiempoDuracion: "años", horasDia: 8, edadMinima: 18},
  {codigo: "CONT-00011", nombre: "Contrato 2013", nroDuracion: 1, tiempoDuracion: "años", horasDia: 8, edadMinima: 18},
  {codigo: "CONT-00012", nombre: "Contrato 2014", nroDuracion: 1, tiempoDuracion: "años", horasDia: 8, edadMinima: 18},
  {codigo: "CONT-00013", nombre: "Contrato 2015", nroDuracion: 1, tiempoDuracion: "años", horasDia: 8, edadMinima: 18},
  {codigo: "CONT-00014", nombre: "Contrato 2016", nroDuracion: 1, tiempoDuracion: "años", horasDia: 8, edadMinima: 18}
])

Departamento.create!([
  {codigo: "DPTO-00002", nombre: "Producción", fechaEnQueDirige: "2016-02-05", empleado_id: nil, supervisor_id: 4},
  {codigo: "DPTO-00003", nombre: "Finanzas", fechaEnQueDirige: "2016-02-05", empleado_id: nil, supervisor_id: 9},
  {codigo: "DPTO-00004", nombre: "Sistemas", fechaEnQueDirige: "2014-01-01", empleado_id: nil, supervisor_id: 10},
  {codigo: "DPTO-00001", nombre: "Compras", fechaEnQueDirige: "2016-02-05", empleado_id: nil, supervisor_id: 8}
])

Proyecto.create!([
  {codigo: "PR-00001", nombre: "Proyecto Compras 1", departamento_id: 1, empleado_id: nil},
  {codigo: "PR-00002", nombre: "Proyecto Compras 2", departamento_id: 1, empleado_id: nil},
  {codigo: "PR-00003", nombre: "Proyecto Finanzas 1", departamento_id: 3, empleado_id: nil},
  {codigo: "PR-00004", nombre: "Proyecto Produccion 1", departamento_id: 2, empleado_id: nil}
])

Rol.create!([
  {nombre: "Administrador"},
  {nombre: "Supervisor"},
  {nombre: "Empleado"}
])

Feriado.create!([
  {descripcion: "2016-San Martin", fecha: "2016-08-15"},
  {descripcion: "2016-Año nuevo", fecha: "2016-01-01"},
  {descripcion: "2016-Carnaval", fecha: "2016-02-08"},
  {descripcion: "2016-Carnaval", fecha: "2016-02-09"},
  {descripcion: "2016-Dia de la Memoria, Jueves Santo", fecha: "2016-03-24"},
  {descripcion: "2016-Viernes Santo", fecha: "2016-03-25"},
  {descripcion: "2016-Dia del veterano - Malvinas", fecha: "2016-04-02"},
  {descripcion: "2016-Dia del Trabajador", fecha: "2016-05-01"},
  {descripcion: "2016-Revolucion de Mayo", fecha: "2016-05-25"},
  {descripcion: "2016-Miguel de Guemes", fecha: "2016-06-17"},
  {descripcion: "2016-Manuel Belgrano", fecha: "2016-06-20"},
  {descripcion: "2016-Feriado Puente", fecha: "2016-07-08"},
  {descripcion: "2016-Dia de la Independencia", fecha: "2016-07-09"}
])

Empleado.create!([
  {codigo: "EMP-00005", dni: "30444512", nombre: "Juliana", apellido: "Castiglione", fechaNacimiento: "1980-12-09", direccion: "Brisas 3280", antiguedad: 12, categoria_id: 3, departamento_id: 1, proyecto_id: nil},
  {codigo: "EMP-00001", dni: "33958772", nombre: "Berta", apellido: "Rivera", fechaNacimiento: "1989-04-11", direccion: "Leandro Gomez 5886", antiguedad: 4, categoria_id: 2, departamento_id: 3, proyecto_id: nil},
  {codigo: "EMP-00010", dni: "36063076", nombre: "Ana", apellido: "Canteros", fechaNacimiento: "1991-11-05", direccion: "Calle 176 Nro. 7141", antiguedad: 2, categoria_id: 5, departamento_id: 4, proyecto_id: nil},
  {codigo: "EMP-00002", dni: "19423568", nombre: "Nahuel", apellido: "Estevez", fechaNacimiento: "1966-11-28", direccion: "Av. Alta Gracia 5332", antiguedad: 3, categoria_id: 1, departamento_id: 1, proyecto_id: nil},
  {codigo: "EMP-00003", dni: "25334991", nombre: "Hilda", apellido: "Zielinski", fechaNacimiento: "1970-04-07", direccion: "Joaquin Suarez 6863", antiguedad: 8, categoria_id: 1, departamento_id: 3, proyecto_id: nil},
  {codigo: "EMP-00004", dni: "25221305", nombre: "Pablo", apellido: "Gomez", fechaNacimiento: "1970-03-05", direccion: "Neruda 7393", antiguedad: 9, categoria_id: 1, departamento_id: 2, proyecto_id: nil},
  {codigo: "EMP-00006", dni: "35421824", nombre: "Ignacio", apellido: "Marino", fechaNacimiento: "1991-06-24", direccion: "Bajada Vieja 844", antiguedad: 0, categoria_id: 2, departamento_id: 2, proyecto_id: nil},
  {codigo: "EMP-00007", dni: "36063876", nombre: "Lara", apellido: "Riveros", fechaNacimiento: "1991-10-22", direccion: "Colon 123", antiguedad: 0, categoria_id: 4, departamento_id: 1, proyecto_id: nil},
  {codigo: "EMP-00008", dni: "38994567", nombre: "Matilde", apellido: "Santos", fechaNacimiento: "1994-08-08", direccion: "Ombu 4942", antiguedad: 0, categoria_id: 4, departamento_id: 2, proyecto_id: nil},
  {codigo: "EMP-00009", dni: "35666222", nombre: "Luis", apellido: "Ribeiro", fechaNacimiento: "1990-01-03", direccion: "Colombia 2351", antiguedad: 0, categoria_id: 3, departamento_id: 3, proyecto_id: nil}
])

ContratoEmpleado.create!([
  {inicio: "2004-03-02", fin: "2014-03-02", contrato_id: 2, empleado_id: 2},
  {inicio: "2014-03-02", fin: "2015-03-02", contrato_id: 12, empleado_id: 2},
  {inicio: "2015-03-02", fin: "2016-03-02", contrato_id: 13, empleado_id: 2},
  {inicio: "2016-03-02", fin: "2017-03-02", contrato_id: 14, empleado_id: 2},
  {inicio: "2012-01-07", fin: "2017-01-07", contrato_id: 1, empleado_id: 1},
  {inicio: "2014-01-01", fin: "2019-01-01", contrato_id: 1, empleado_id: 10},
  {inicio: "2013-01-01", fin: "2018-01-01", contrato_id: 1, empleado_id: 8},
  {inicio: "2008-01-01", fin: "2018-01-01", contrato_id: 2, empleado_id: 9},
  {inicio: "2007-01-01", fin: "2017-01-01", contrato_id: 2, empleado_id: 4},
  {inicio: "2016-01-01", fin: "2017-01-01", contrato_id: 14, empleado_id: 5},
  {inicio: "2016-01-01", fin: "2017-01-01", contrato_id: 14, empleado_id: 3},
  {inicio: "2016-01-01", fin: "2016-04-01", contrato_id: 7, empleado_id: 6},
  {inicio: "2016-01-01", fin: "2017-01-01", contrato_id: 14, empleado_id: 7}
])

EmpleadoProyecto.create!([
  {empleado_id: 1, proyecto_id: 1},
  {empleado_id: 2, proyecto_id: 1},
  {empleado_id: 1, proyecto_id: 2},
  {empleado_id: 3, proyecto_id: 2},
  {empleado_id: 7, proyecto_id: 3},
  {empleado_id: 8, proyecto_id: 3},
  {empleado_id: 9, proyecto_id: 3},
  {empleado_id: 6, proyecto_id: 4},
  {empleado_id: 4, proyecto_id: 4},
  {empleado_id: 5, proyecto_id: 4}
])

Horario.create!([
  {codigo: "HR-00001", nombre: "Mañana", dia: "0, 1, 2, 3, 4", horaEntrada: "2000-01-01 08:00:00", horaSalida: "2000-01-01 12:00:00", margenEntradaCheck: true, margenSalidaCheck: true, inicioMargenEntrada: "2000-01-01 07:50:00", finMargenEntrada: "2000-01-01 08:10:00", inicioMargenSalida: "2000-01-01 12:00:00", finMargenSalida: "2000-01-01 12:15:00", empleado_id: nil},
  {codigo: "HR-00002", nombre: "Tarde", dia: "0, 1, 2, 3, 4", horaEntrada: "2000-01-01 16:00:00", horaSalida: "2000-01-01 20:00:00", margenEntradaCheck: true, margenSalidaCheck: true, inicioMargenEntrada: "2000-01-01 15:50:00", finMargenEntrada: "2000-01-01 16:10:00", inicioMargenSalida: "2000-01-01 20:00:00", finMargenSalida: "2000-01-01 20:15:00", empleado_id: nil}
])

HorarioEmpleado.create!([
  {fechaInicio: "2015-07-01", horario_id: 1, empleado_id: 1},
  {fechaInicio: "2015-11-17", horario_id: 2, empleado_id: 1},
  {fechaInicio: "2015-09-01", horario_id: 2, empleado_id: 2},
  {fechaInicio: "2016-01-01", horario_id: 1, empleado_id: 1},
  {fechaInicio: "2016-04-01", horario_id: 2, empleado_id: 1},
  {fechaInicio: "2014-01-01", horario_id: 1, empleado_id: 10},
  {fechaInicio: "2014-01-01", horario_id: 2, empleado_id: 10},
  {fechaInicio: "2013-01-01", horario_id: 1, empleado_id: 8},
  {fechaInicio: "2013-01-01", horario_id: 2, empleado_id: 8},
  {fechaInicio: "2008-01-01", horario_id: 1, empleado_id: 9},
  {fechaInicio: "2008-01-01", horario_id: 2, empleado_id: 9},
  {fechaInicio: "2007-01-01", horario_id: 1, empleado_id: 4},
  {fechaInicio: "2007-01-01", horario_id: 2, empleado_id: 4},
  {fechaInicio: "2004-03-02", horario_id: 1, empleado_id: 2},
  {fechaInicio: "2016-01-01", horario_id: 1, empleado_id: 5},
  {fechaInicio: "2016-01-01", horario_id: 1, empleado_id: 3},
  {fechaInicio: "2016-01-01", horario_id: 1, empleado_id: 6},
  {fechaInicio: "2016-01-01", horario_id: 1, empleado_id: 7},
  {fechaInicio: "2016-01-01", horario_id: 2, empleado_id: 7}
])

Usuario.create!([
  {userName: "EMP-00010", password: "1234", empleado_id: 10, rol_id: 1},
  {userName: "EMP-00001", password: "NONE", empleado_id: 1, rol_id: 3},
  {userName: "EMP-00005", password: "NONE", empleado_id: 2, rol_id: 3},
  {userName: "EMP-00007", password: "NONE", empleado_id: 3, rol_id: 3},
  {userName: "EMP-00002", password: "NONE", empleado_id: 8, rol_id: 2},
  {userName: "EMP-00003", password: "NONE", empleado_id: 9, rol_id: 2},
  {userName: "EMP-00004", password: "NONE", empleado_id: 4, rol_id: 2},
  {userName: "EMP-00006", password: "NONE", empleado_id: 5, rol_id: 3},
  {userName: "EMP-00008", password: "NONE", empleado_id: 6, rol_id: 3},
  {userName: "EMP-00009", password: "NONE", empleado_id: 7, rol_id: 3}
])

HoraExtra.create!([
  {codigo: "H.EXT-00001", nombre: "Matutino Lunes a Viernes", dia: "0, 1, 2, 3, 4", horaInicio: "2000-01-01 08:00:00", horaFin: "2000-01-01 22:00:00", precio: 50.0},
  {codigo: "H.EXT-00002", nombre: "Sábados 8-13pm", dia: "5", horaInicio: "2000-01-01 08:00:00", horaFin: "2000-01-01 12:59:00", precio: 50.0},
  {codigo: "H.EXT-00003", nombre: "Sábados 13pm", dia: "5", horaInicio: "2000-01-01 13:00:00", horaFin: "2000-01-01 23:59:00", precio: 100.0},
  {codigo: "H.EXT-00004", nombre: "Domingos", dia: "6", horaInicio: "2000-01-01 00:00:00", horaFin: "2000-01-01 23:59:00", precio: 100.0},
  {codigo: "H.EXT-00005", nombre: "Feriados", dia: "0, 1, 2, 3, 4, 5, 6", horaInicio: "2000-01-01 00:00:00", horaFin: "2000-01-01 23:59:00", precio: 100.0}
])

Incidencia.create!([
  {codigo: "INC-00001", nombre: "Vacaciones 14 días", nroDuracion: 14, tiempoDuracion: "días", tieneCondiciones: true, tienePeriodoHabilitacion: true, fechaInicioHabilitacion: "2016-10-01", fechaFinHabilitacion: "2016-04-30", tieneRestriccionAntiguedad: true, nroAntiguedadMayor: 0, tiempoAntiguedadMayor: "años", nroAntiguedadMenor: 5, tiempoAntiguedadMenor: "años", tieneCantPermitidasPorAnio: false, vecesPermitidasPorAnio: nil, descuento: nil},
  {codigo: "INC-00002", nombre: "Vacaciones 21 días", nroDuracion: 21, tiempoDuracion: "días", tieneCondiciones: true, tienePeriodoHabilitacion: true, fechaInicioHabilitacion: "2016-10-01", fechaFinHabilitacion: "2016-04-30", tieneRestriccionAntiguedad: true, nroAntiguedadMayor: 5, tiempoAntiguedadMayor: "años", nroAntiguedadMenor: 10, tiempoAntiguedadMenor: "años", tieneCantPermitidasPorAnio: false, vecesPermitidasPorAnio: nil, descuento: nil},
  {codigo: "INC-00003", nombre: "Vacaciones 28 días", nroDuracion: 28, tiempoDuracion: "días", tieneCondiciones: true, tienePeriodoHabilitacion: true, fechaInicioHabilitacion: "2016-10-01", fechaFinHabilitacion: "2016-04-30", tieneRestriccionAntiguedad: true, nroAntiguedadMayor: 10, tiempoAntiguedadMayor: "años", nroAntiguedadMenor: 20, tiempoAntiguedadMenor: "años", tieneCantPermitidasPorAnio: false, vecesPermitidasPorAnio: nil, descuento: nil},
  {codigo: "INC-00004", nombre: "Vacaciones 35 días", nroDuracion: 35, tiempoDuracion: "días", tieneCondiciones: true, tienePeriodoHabilitacion: true, fechaInicioHabilitacion: "2016-10-01", fechaFinHabilitacion: "2016-04-30", tieneRestriccionAntiguedad: true, nroAntiguedadMayor: 20, tiempoAntiguedadMayor: "años", nroAntiguedadMenor: nil, tiempoAntiguedadMenor: "días", tieneCantPermitidasPorAnio: false, vecesPermitidasPorAnio: nil, descuento: nil},
  {codigo: "INC-00005", nombre: "Licencia Nacimiento de Hijo", nroDuracion: 2, tiempoDuracion: "días", tieneCondiciones: false, tienePeriodoHabilitacion: false, fechaInicioHabilitacion: "2016-03-01", fechaFinHabilitacion: "2016-03-01", tieneRestriccionAntiguedad: false, nroAntiguedadMayor: nil, tiempoAntiguedadMayor: "días", nroAntiguedadMenor: nil, tiempoAntiguedadMenor: "días", tieneCantPermitidasPorAnio: false, vecesPermitidasPorAnio: nil, descuento: nil},
  {codigo: "INC-00006", nombre: "Licencia por Matrimonio", nroDuracion: 10, tiempoDuracion: "días", tieneCondiciones: false, tienePeriodoHabilitacion: false, fechaInicioHabilitacion: "2016-03-01", fechaFinHabilitacion: "2016-03-01", tieneRestriccionAntiguedad: false, nroAntiguedadMayor: nil, tiempoAntiguedadMayor: "días", nroAntiguedadMenor: nil, tiempoAntiguedadMenor: "días", tieneCantPermitidasPorAnio: false, vecesPermitidasPorAnio: nil, descuento: nil},
  {codigo: "INC-00007", nombre: "Licencia por fallecimiento de cónyuge, padre o hijo", nroDuracion: 3, tiempoDuracion: "días", tieneCondiciones: false, tienePeriodoHabilitacion: false, fechaInicioHabilitacion: "2016-03-01", fechaFinHabilitacion: "2016-03-01", tieneRestriccionAntiguedad: false, nroAntiguedadMayor: nil, tiempoAntiguedadMayor: "días", nroAntiguedadMenor: nil, tiempoAntiguedadMenor: "días", tieneCantPermitidasPorAnio: false, vecesPermitidasPorAnio: nil, descuento: nil},
  {codigo: "INC-00008", nombre: "Licencia por fallecimiento de hermano", nroDuracion: 1, tiempoDuracion: "días", tieneCondiciones: false, tienePeriodoHabilitacion: false, fechaInicioHabilitacion: "2016-03-01", fechaFinHabilitacion: "2016-03-01", tieneRestriccionAntiguedad: false, nroAntiguedadMayor: nil, tiempoAntiguedadMayor: "días", nroAntiguedadMenor: nil, tiempoAntiguedadMenor: "días", tieneCantPermitidasPorAnio: false, vecesPermitidasPorAnio: nil, descuento: nil},
  {codigo: "INC-00009", nombre: "Licencia por Exámen", nroDuracion: 2, tiempoDuracion: "días", tieneCondiciones: true, tienePeriodoHabilitacion: false, fechaInicioHabilitacion: "2016-03-01", fechaFinHabilitacion: "2016-03-01", tieneRestriccionAntiguedad: false, nroAntiguedadMayor: nil, tiempoAntiguedadMayor: "días", nroAntiguedadMenor: nil, tiempoAntiguedadMenor: "días", tieneCantPermitidasPorAnio: true, vecesPermitidasPorAnio: 5, descuento: nil},
  {codigo: "INC-00010", nombre: "Licencia por Embarazo", nroDuracion: 90, tiempoDuracion: "días", tieneCondiciones: false, tienePeriodoHabilitacion: false, fechaInicioHabilitacion: "2016-03-01", fechaFinHabilitacion: "2016-03-01", tieneRestriccionAntiguedad: false, nroAntiguedadMayor: nil, tiempoAntiguedadMayor: "días", nroAntiguedadMenor: nil, tiempoAntiguedadMenor: "días", tieneCantPermitidasPorAnio: false, vecesPermitidasPorAnio: nil, descuento: nil}
])

IncidenciaEmpleado.create!([
  {inicio: "2016-03-09 03:00:00", fin: "2016-03-30 03:00:00", incidencia_id: 2, empleado_id: 9},
  {inicio: "2016-08-08 03:00:00", fin: "2016-08-10 03:00:00", incidencia_id: 9, empleado_id: 8},
  {inicio: "2016-03-09 03:00:00", fin: "2016-03-19 03:00:00", incidencia_id: 6, empleado_id: 4},
  {inicio: "2016-03-10 03:00:00", fin: "2016-06-08 03:00:00", incidencia_id: 10, empleado_id: 3}
])

HorarioEmpleado.create!([
  {fechaInicio: "2015-07-01", horario_id: 1, empleado_id: 1},
  {fechaInicio: "2015-11-17", horario_id: 2, empleado_id: 1},
  {fechaInicio: "2015-09-01", horario_id: 2, empleado_id: 2},
  {fechaInicio: "2016-01-01", horario_id: 1, empleado_id: 1},
  {fechaInicio: "2016-04-01", horario_id: 2, empleado_id: 1},
  {fechaInicio: "2014-01-01", horario_id: 1, empleado_id: 10},
  {fechaInicio: "2014-01-01", horario_id: 2, empleado_id: 10},
  {fechaInicio: "2013-01-01", horario_id: 1, empleado_id: 8},
  {fechaInicio: "2013-01-01", horario_id: 2, empleado_id: 8},
  {fechaInicio: "2008-01-01", horario_id: 1, empleado_id: 9},
  {fechaInicio: "2008-01-01", horario_id: 2, empleado_id: 9},
  {fechaInicio: "2007-01-01", horario_id: 1, empleado_id: 4},
  {fechaInicio: "2007-01-01", horario_id: 2, empleado_id: 4},
  {fechaInicio: "2004-03-02", horario_id: 1, empleado_id: 2},
  {fechaInicio: "2016-01-01", horario_id: 1, empleado_id: 5},
  {fechaInicio: "2016-01-01", horario_id: 1, empleado_id: 3},
  {fechaInicio: "2016-01-01", horario_id: 1, empleado_id: 6},
  {fechaInicio: "2016-01-01", horario_id: 1, empleado_id: 7},
  {fechaInicio: "2016-01-01", horario_id: 2, empleado_id: 7}
])