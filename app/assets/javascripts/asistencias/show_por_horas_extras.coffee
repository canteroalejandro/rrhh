//= require moment
//= require moment.es
//= require bootstrap-datetimepicker

$(document).ready ->
  fecha = new Date dateServerRender()

  $('#fecha').datetimepicker
    format: "MM/YYYY"
    viewMode: "months"
    date: fecha
    # startView: "month",

  # $('#fecha').datetimepicker()
  #   defaultDate: new Date()
  #   format: 'MM/yyyy'
  #   pickTime: false
  #   endDate: fecha
  #   viewMode: "months"
  #   minViewMode: "months"

  # $('#fecha').Datetimepicker('setValue', fecha)



  $("#bt-filtrar").click ->
    $("#spin-ajax").show()
    $.post( "/empleados/#{$("#empleado_id").val()}/ajax_table_por_horas_extras", $("#parametros").serialize())
      .done (data) ->
        $("#spin-ajax").hide()
        $("#table-customized").empty()
        $("#table-customized").append data