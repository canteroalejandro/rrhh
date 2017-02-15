(function() {
  $(document).ready(function() {
    return $("#contrato_indeterminado[type='checkbox']").change(function() {
      if ($(this).is(':checked')) {
        $("#renovable-group").hide();
        return $("#duracion-group").hide();
      } else {
        $("#renovable-group").show();
        return $("#duracion-group").show();
      }
    });
  });

}).call(this);
