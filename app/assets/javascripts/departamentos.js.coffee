# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require jquery.chained

$(document).ready ->
  $("#departamento_provincia_id").chained("#departamento_pais_id")
  
  `$("#series").chained("#mark");
  $("#model").chained("#series");
  $("#engine").chained("#series, #model");

  /* Show button after each pulldown has a value. */
  $("#engine").bind("change", function(event) {
      if ("" != $("option:selected", this).val() && "" != $("option:selected", $("#model")).val()) {
          $("#button").fadeIn();
      } else {
          $("#button").hide();          
      }
  })`