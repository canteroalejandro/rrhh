# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

//= require select2
//= require jquery.chained

$(document).ready ->
  $('select#empleado_id').select2 {}
  $('select#horario_empleado_id').select2 {}
  $("#horario_empleado_id").chained("#empleado_id")
  return


