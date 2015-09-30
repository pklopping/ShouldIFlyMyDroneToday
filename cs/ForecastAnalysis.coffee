window.ForecastAnalysis = class ForecastAnalysis
	acceptable_fixed_wing_windspeed: 15 # mph
	acceptable_multi_rotor_windspeed: 10 # mph
	acceptable_precipitation_probability: 0.05

	short_answer_selector: 'p.short_answer'
	current_weather_selector: 'fieldset.current_weather'
	constructor: (raw_data, waterproof, fixed_wing) ->
		console.log "ForecastAnalysis constructed"
		overall_answer = true # Should the user fly today? Let's start positive and falsify it if necessary
		currently = raw_data.currently # For this version, we'll only be checking the current weather

		#The following lines are overkill
		overall_answer = if @check_precipitation(currently, waterproof) then overall_answer else false 
		overall_answer = if @check_windspeed(currently, fixed_wing) then overall_answer else false

		@update_interface(currently, overall_answer)

	check_windspeed: (data, fixed_wing) ->
		if fixed_wing
			return data.windSpeed < @acceptable_fixed_wing_windspeed
		else
			return data.windSpeed < @acceptable_multi_rotor_windspeed

	check_precipitation: (data, waterproof) ->
		if waterproof
			return true # If it's waterproof, rain won't hurt it
		else
			return data.precipProbability < @acceptable_precipitation_probability

	update_interface: (data, fly_or_no) ->

		# Update the short answer
		wordy_response = if fly_or_no then "Yes you should! Get out there!" else "No, the weather isn't acting in your favor"
		$(@short_answer_selector).html(wordy_response)

		# Update the Curent weather
		$current_weather = $(@current_weather_selector)

		#clear existing things
		$current_weather.children().not('legend').remove()

		# Salient flying details
		$current_weather
			.append('<p>Summary: '+data.summary+'</p>')
			.append('<p>Temperature: '+Math.round(data.temperature)+'F</p>')
			.append('<p>Precipitation: %'+(data.precipProbability*100)+'</p>')
			.append('<p>Wind Speed: '+Math.round(data.windSpeed)+'mph</p>')
			# .append('<p>Summary: '+data.+'</p>')
