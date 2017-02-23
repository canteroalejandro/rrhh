# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	$("form").on "change", "#usuario_empleado_id", ->
		codigo = $(this).find("option:selected").data("emp-code")
		$("#usuario_userName").val(codigo)

	$("#new_usuario").find("#usuario_empleado_id").change()