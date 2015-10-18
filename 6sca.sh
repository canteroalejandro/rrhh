source ~/.rvm/scripts/rvm

rails generate scaffold Cliente nombre:string nroCtaMunicipal:string \
cbu:string claveAfip:string

rails generate scaffold Contador nombre:string 