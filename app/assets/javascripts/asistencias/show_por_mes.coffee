//= require moment
//= require moment.es
//= require bootstrap-datetimepicker

$(document).ready ->
  fecha = new Date dateServerRender()

  # $('#fecha').datetimepicker
  #   format: 'MM/YYYY'
  #   date: fecha

  $('#fecha').datetimepicker
    format: "MM/YYYY"
    viewMode: "months"
    date: fecha

  $("#bt-filtrar").click ->
    $("#spin-ajax").show()
    $.post( "/empleados/#{$("#empleado_id").val()}/ajax_table_por_mes", $("#parametros").serialize())
      .done (data) ->
        $("#spin-ajax").hide()
        $("#table-customized").empty()
        $("#table-customized").append data