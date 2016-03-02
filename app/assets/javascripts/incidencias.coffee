# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
	if $('#check_condiciones').is(':checked') 
		$('#panel').show()
	else
		$('#panel').hide()
	$('#check_condiciones').change ->
		$("#panel").toggle(@checked)

  