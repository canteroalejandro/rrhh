# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
//= require select2
//= require jquery.bootstrap-duallistbox.min
//= require fuelux_fuelux.wizard.min


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

    
  $('#fuelux-wizard-container')
    .ace_wizard
      buttons: '.wizard-actions:eq(0)'

  $('#fuelux-wizard-container')
    .on 'finished.fu.wizard', (evt, data) ->
      console.log $("form").serializeArray()
    .on 'actionclicked.fu.wizard', (evt, data) ->
      $('html, body').animate
        scrollTop: $('#wizard-container').offset().top
      , 400
      
      if data.step == 2 and data.direction == 'next'
        # Validacion para continuar el sgte paso.
        if $("select[name='empleado_ids[]_helper2'] option").length == 0
          evt.preventDefault()
          alert "No ha seleccionado ningun empleado."
        else
          # Prepara el combo para la seleccion del supervisor.
          # Cargando los nuevos empleados asignados.
          $("#supervisor_id").empty()
          $("select[name='empleado_ids[]_helper2'] option").each (index, value)->
            $("#supervisor_id").append $(value).clone()

            # Comprueba si esta en modo edit.
            if $("#dpto_supervisor_id").length
              $("#supervisor_id").val $("#dpto_supervisor_id").val()

      if data.step == 3 and data.direction == 'next'
        if $("#supervisor_id").val() == null
          evt.preventDefault()
          alert "No ha seleccionado ningun supervisor."
        else
          # Cargar el Resumen

          $("#lblCodigo").text $("#departamento_codigo").val()
          $("#lblNombre").text $("#departamento_nombre").val()
          $("#lblSupervisor").text $("#supervisor_id option:selected").text();
          
          $("#ulEmpleados").empty()
          
          $("select[name='empleado_ids[]_helper2'] option").each (index, value)->
            if $(value).val() != $("#supervisor_id").val()
              $("#ulEmpleados").append($("<li>").append( $(value).clone().text() ) )


            # $("#supervisor_id").append $(value).clone()




      #   unless is_detalle_de_pedido()
      #     evt.preventDefault()
      #     alert("No selecciono ningun producto para este Pedido.")