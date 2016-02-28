# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
//= require select2

$(document).ready ->
  $('select#empleado_multiple').select2 {}
  $("#empleado_supervisor").change ->
  	val = $(this).val()
  	$("#empleado_multiple option").each (index, value)->
  		if $(value).val() == val
  			$(value).attr("selected", true)
  		else
  		 	$(value).attr("selected", false)
  	  #console.log "index", index
  	  #console.log "value", value

  	#.prop("disabled", true)

