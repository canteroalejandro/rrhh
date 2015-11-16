Categoria.create!([
  {codigo: "CA-00001", nombre: "Gerente de Departamento", salarioBase: "41236.0"},
  {codigo: "CA-00002", nombre: "Jefe de Proyecto", salarioBase: "20124.0"},
  {codigo: "CA-00003", nombre: "Analista Senior", salarioBase: "19786.0"},
  {codigo: "CA-00004", nombre: "Analista Junior", salarioBase: "12057.0"}
])

Sexo.create!([
  {sexo: "Masculino"},
  {sexo: "Femenino"}
])

Empleado.create!([
  {codigo: "EMP-00001", dni: "33958772", nombre: "Berta", apellido: "Rivera", fechaNacimiento: "1989-04-11", direccion: "Leandro Gomez 5886", categoria_id: 1, sexo_id: 2},
  {codigo: "EMP-00002", dni: "19423568", nombre: "Nahuel", apellido: "Estevez", fechaNacimiento: "1966-11-28", direccion: "Av. Alta Gracia 5332", categoria_id: 1, sexo_id: 1},
  {codigo: "EMP-00003", dni: "25334991", nombre: "Hilda", apellido: "Zielinski", fechaNacimiento: "1970-04-07", direccion: "Joaquin Suarez 6863", categoria_id: 2, sexo_id: 2},
  {codigo: "EMP-00004", dni: "25221305", nombre: "Pablo", apellido: "Gomez", fechaNacimiento: "1970-03-05", direccion: "Neruda 7393", categoria_id: 2, sexo_id: 1},
  {codigo: "EMP-00005", dni: "30444512", nombre: "Juliana", apellido: "Castiglione", fechaNacimiento: "1980-12-09", direccion: "Brisas 3280", categoria_id: 3, sexo_id: 2},
  {codigo: "EMP-00006", dni: "35421824", nombre: "Ignacio", apellido: "Marino", fechaNacimiento: "1991-06-24", direccion: "Bajada Vieja 844", categoria_id: 4, sexo_id: 1},
  {codigo: "EMP-00007", dni: "36063876", nombre: "Lara", apellido: "Riveros", fechaNacimiento: "1991-10-22", direccion: "Colon 123", categoria_id: 4, sexo_id: 2},
  {codigo: "EMP-00008", dni: "38994567", nombre: "Matilde", apellido: "Santos", fechaNacimiento: "1994-08-08", direccion: "Ombu 4942", categoria_id: 4, sexo_id: 2},
  {codigo: "EMP-00009", dni: "35666222", nombre: "Luis", apellido: "Ribeiro", fechaNacimiento: "1990-01-03", direccion: "Colombia 2351", categoria_id: 3, sexo_id: 1}
])
