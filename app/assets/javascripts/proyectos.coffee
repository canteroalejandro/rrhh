# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

//= require select2
//= require jquery.chained

$(document).ready ->
  $('select#empleado_ids').select2 {}
  $('select#departementoo_id').select2 {}
  $("#empleado_ids").chained("#departamento_id")
  return