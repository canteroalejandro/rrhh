//= require moment
//= require moment.es
//= require bootstrap-datetimepicker

//= require jquery-ui.custom.min
//= require jquery.ui.touch-punch.min
//= require fullcalendar.min

crearCalendar = ()->

  data = $("#calendar").data("horario")
  
  hash_colores = $("#calendar").data("labels")

  console.log hash_colores

  detalles= []

  if data[0].horaSalida != undefined
    i = data.length - 1
    while i >= 0
      data[i]
      detalles.push
        title: data[i].codigo_proyecto
        start: data[i].horaEntrada
        end: data[i].horaSalida
        proyecto_id: data[i].proyecto_id
        className: 'label-' + hash_colores[ data[i].proyecto_id ]
      i--
  else
    data = {}


  # new Date(year, month, day, hours, minutes, seconds, milliseconds);
  calendar = $('#calendar').fullCalendar(
    buttonHtml:
      prev: '<i class="ace-icon fa fa-chevron-left"></i>'
      next: '<i class="ace-icon fa fa-chevron-right"></i>'
    defaultDate: moment('2017-05-01')
    header: {}
    allDaySlot: false
    defaultView: 'basicWeek'
    timeFormat: 'HH:mm'
    displayEventEnd: true
    firstDay: 1
    height: 175
    width: 800
    events: detalles
    allDayDefault: false
    forceEventDuration: true
  )
  $('.fc-toolbar').hide()

  $('.fc-day-header.fc-sun:first').html 'Domingo'
  $('.fc-day-header.fc-mon:first').html 'Lunes'
  $('.fc-day-header.fc-tue:first').html 'Martes'
  $('.fc-day-header.fc-wed:first').html 'Miercoles'
  $('.fc-day-header.fc-thu:first').html 'Jueves'
  $('.fc-day-header.fc-fri:first').html 'Viernes'
  $('.fc-day-header.fc-sat:first').html 'Sabado'

$(document).ready ->
  fecha = new Date dateServerRender()

  crearCalendar()
  
  $('#fecha').datetimepicker
    format: "MM/YYYY"
    viewMode: "months"
    date: fecha

  $("#bt-filtrar").click ->
    $("#spin-ajax").show()
    $.post( "/empleados/#{$("#empleado_id").val()}/ajax_table_por_horas_extras", $("#parametros").serialize())
      .done (data) ->
        $("#spin-ajax").hide()
        $("#table-customized").empty()
        $("#table-customized").append data