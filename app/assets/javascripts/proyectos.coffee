# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

//= require select2
//= require jquery.chained

$(document).ready ->
  $('#empleado_ids').select2 {}
  $('#departamento_id').select2 {}
  #$("#empleado_ids").chained("#departamento_id")

  #$('#empleado_ids').parent().hide()
  empleados = $('#empleado_ids').html()
  $('#departamento_id').change ->
  	departamento = $('#departamento_id :selected').text()
  	options = $(empleados).filter((index)->
  		$(this).attr("label") is departamento)
  	if options
        $('#empleado_ids').html(options)
        #$('#empleado_ids').parent().show()
    else
        $('#empleado_ids').empty()
        #$('#empleado_ids').parent().hide()
  #$("#empleado_ids").trigger "change"
  return