# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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
      url: "/assets/dataTables.Spanish.txt"


$(document).ready ->
  crearDataTable("#usuarios-table")

  $("form").on "change", "#usuario_empleado_id", ->
    codigo = $(this).find("option:selected").data("emp-code")
    $("#usuario_userName").val(codigo)

  $("#new_usuario").find("#usuario_empleado_id").change()