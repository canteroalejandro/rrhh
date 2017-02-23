# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

//= require jquery-ui.custom.min
//= require jquery.ui.touch-punch.min
//= require moment
//= require fullcalendar.min
//= require bootbox
//= require jquery.collapser.min


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
      # { type: 'date-eu', targets: 3 }
    # ]
    language:
      url: "/assets/dataTables.Spanish.txt"

$(document).ready ->
  $("#descripcion-categoria").collapser
    mode: 'chars'
    truncate: 30
    showText: '[ver mas]'
    hideText: '[ver menos]'

  crearDataTable("#empleados-table")

#   tab_estadistica = $("#asistencias")
#   is_show = $(tab_estadistica).hasClass("active in")
#   if not is_show
#     $(tab_estadistica).addClass("active in")
  
#   Morris.Bar
#     element: 'stats-chart'
#     data: JSON.parse(stats_data_str),
#     xkey: 'y'
#     ykeys: ['a', 'i']
#     labels: ['Asistencias', 'Inasistencias']
  
#   if not is_show
#     $(tab_estadistica).removeClass("active in")