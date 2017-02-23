# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
//= require select2
//= require jquery.chained

//= require jquery.dataTables.min
//= require jquery.dataTables.bootstrap.min

crearDataTable = (selector)->
  $(selector).DataTable
    "lengthMenu": [ 25, 50, 75, 100 ]
    # columns: [
    #   { width: "5%" },
    #   { width: "7%" },
    #   { width: "10%" },
    #   { width: "10%" },
    #   { width: "40%" }
    # ],
    # "pageLength": 4,
    # lengthChange: false,
    # searching: false,
    # bInfo: false,
    # bPaginate: false,
    # order: [[ 1, "asc" ]],
    # aaSorting: [ [1,'desc'] ],
    # columnDefs: [
    #   { type: 'date-eu', targets: 3 }
    # ]
    "language":
      url: "https://cdn.datatables.net/plug-ins/1.10.13/i18n/Spanish.json"

$(document).ready ->
  crearDataTable("#proyectos-table")

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