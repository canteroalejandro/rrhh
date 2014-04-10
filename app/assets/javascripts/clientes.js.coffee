# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require jquery.chained

$(document).ready ->
  $("#provincia_id").chained("#pais_id")
  $("#departamento_id").chained("#pais_id, #provincia_id")
  $("#localidad_id").chained("#pais_id, #provincia_id, #departamento_id")