// Generated by CoffeeScript 1.10.0
(function() {
  var ForecastAnalysis;

  window.ForecastAnalysis = ForecastAnalysis = (function() {
    ForecastAnalysis.prototype.acceptable_fixed_wing_windspeed = 15;

    ForecastAnalysis.prototype.acceptable_multi_rotor_windspeed = 10;

    ForecastAnalysis.prototype.acceptable_precipitation_probability = 0.05;

    ForecastAnalysis.prototype.short_answer_selector = 'p.short_answer';

    ForecastAnalysis.prototype.current_weather_selector = 'fieldset.current_weather';

    function ForecastAnalysis(raw_data, waterproof, fixed_wing, illuminated) {
      var currently, overall_answer, today;
      console.log("ForecastAnalysis constructed");
      overall_answer = true;
      currently = raw_data.currently;
      today = raw_data.daily.data[0];
      overall_answer = this.check_precipitation(currently, waterproof) ? overall_answer : false;
      overall_answer = this.check_windspeed(currently, fixed_wing) ? overall_answer : false;
      overall_answer = this.check_daylight(today, illuminated) ? overall_answer : false;
      this.update_interface(raw_data, overall_answer);
    }

    ForecastAnalysis.prototype.check_daylight = function(today, illuminated) {
      if (illuminated) {
        return true;
      } else {
        return today.sunriseTime < Date.now() && Date.now() < today.sunsetTime;
      }
    };

    ForecastAnalysis.prototype.check_windspeed = function(data, fixed_wing) {
      if (fixed_wing) {
        return data.windSpeed < this.acceptable_fixed_wing_windspeed;
      } else {
        return data.windSpeed < this.acceptable_multi_rotor_windspeed;
      }
    };

    ForecastAnalysis.prototype.check_precipitation = function(data, waterproof) {
      if (waterproof) {
        return true;
      } else {
        return data.precipProbability < this.acceptable_precipitation_probability;
      }
    };

    ForecastAnalysis.prototype.update_interface = function(raw_data, fly_or_no) {
      var $current_weather, currently, remaining_sunlight, sunlight, today, wordy_response;
      wordy_response = fly_or_no ? "Yes you should! Get out there!" : "No, the weather isn't acting in your favor";
      $(this.short_answer_selector).html(wordy_response);
      $current_weather = $(this.current_weather_selector);
      $current_weather.children().not('legend').remove();
      currently = raw_data.currently;
      today = raw_data.daily.data[0];
      sunlight = today.sunriseTime < Date.now() && Date.now() < today.sunsetTime;
      remaining_sunlight = this.milliseconds_to_hours(today.sunsetTime - Date.now());
      return $current_weather.append('<p>Summary: ' + currently.summary + '</p>').append('<p>Temperature: ' + Math.round(currently.temperature) + 'F</p>').append('<p>Precipitation: %' + (currently.precipProbability * 100) + '</p>').append('<p>Wind Speed: ' + Math.round(currently.windSpeed) + 'mph</p>').append('<p>Sunlight: ' + (sunlight ? "Yup, you've got " + remaining_sunlight + " hours to fly" : "Nope") + '</p>');
    };

    ForecastAnalysis.prototype.milliseconds_to_hours = function(seconds) {
      return (seconds / 1000 / 60 / 60).toFixed(2);
    };

    return ForecastAnalysis;

  })();

}).call(this);
