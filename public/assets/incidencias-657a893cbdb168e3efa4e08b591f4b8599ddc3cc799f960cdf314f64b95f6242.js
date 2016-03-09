(function() {
  $(document).ready(function() {
    if ($('#check_condiciones').is(':checked')) {
      $('#panel').show();
    } else {
      $('#panel').hide();
    }
    return $('#check_condiciones').change(function() {
      return $("#panel").toggle(this.checked);
    });
  });

}).call(this);
