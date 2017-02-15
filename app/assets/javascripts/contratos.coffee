# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#contrato_indeterminado[type='checkbox']").change ->
    if $(this).is(':checked')
      $("#renovable-group").hide()
      $("#duracion-group").hide()
    else
      $("#renovable-group").show()
      $("#duracion-group").show()