source ~/.rvm/scripts/rvm

rails generate scaffold Categoria identificador:string montoMaxFacturado:decimal gastosMaxLuz:decimal fechaVigencia:date

rails generate scaffold Imagen nombre:string fecha:date url_imagen:string

rails generate scaffold EstadoTribAfip clave:string fechaAlta:date condicion:string 

rails generate scaffold PaqueteDeServicio descripcion:string monto:decimal activo:boolean 

rails generate scaffold CuentaCorriente descripcion:string