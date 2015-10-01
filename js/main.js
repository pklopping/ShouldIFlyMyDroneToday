// Generated by CoffeeScript 1.10.0
(function() {
  $(function() {
    console.log("You should probably make this do something. Something impressive preferably.");
    window.fioi = new ForecastIOInterface();
    window.analysis = void 0;
    return $('#submit').on('click', function(e) {
      var lat, lng;
      $(this).attr('disabled', true);
      e.preventDefault();
      e.stopPropagation();
      lat = $('#lat').val();
      lng = $('#lng').val();
      return fioi.query(lat, lng, (function(_this) {
        return function(data) {
          var fixed_wing, illuminated, waterproof;
          $(_this).attr('disabled', false);
          if (data) {
            waterproof = $('#waterproof').is(':checked');
            fixed_wing = $('input[name="aircraft_type"]:checked').val() === "fixed" ? true : false;
            illuminated = $('#illuminated').is(':checked');
            return window.analysis = new ForecastAnalysis(data, waterproof, fixed_wing, illuminated);
          } else {
            return alert("You broke it. Why did you do that? Stop it.");
          }
        };
      })(this));
    });
  });

}).call(this);
