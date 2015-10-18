source ~/.rvm/scripts/rvm

rails generate scaffold Servicio descripcion:string monto:decimal

rails generate scaffold ServicioRealizado descripcion:string monto:decimal fecha:date bonificacion:decimal

rails generate scaffold ItemDeServicio monto_establecido:decimal