source ~/.rvm/scripts/rvm

rails generate scaffold TipoDocumentoComercial nombre:string descripcion:string

rails generate scaffold Movimiento fecha:date descripcion:string nro_documento:string \
 debe:boolean haber:boolean bonifPaqServ:decimal bonifManual:decimal