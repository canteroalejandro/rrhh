# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

//= require bootstrap
//= require jquery-ui.custom.min
//= require jquery.ui.touch-punch.min
//= require moment
//= require fullcalendar.min
//= require bootbox
//= require jquery.collapser.min

# //= require raphael.min
# //= require morris.min

$(document).ready ->
  $("#descripcion-categoria").collapser
    mode: 'chars'
    truncate: 30
    showText: '[ver mas]'
    hideText: '[ver menos]'

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