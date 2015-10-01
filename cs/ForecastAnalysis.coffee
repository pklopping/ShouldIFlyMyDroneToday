window.ForecastAnalysis = class ForecastAnalysis
	acceptable_fixed_wing_windspeed: 15 # mph
	acceptable_multi_rotor_windspeed: 10 # mph
	acceptable_precipitation_probability: 0.05

	short_answer_selector: 'p.short_answer'
	current_weather_selector: 'fieldset.current_weather'
	constructor: (raw_data, waterproof, fixed_wing, illuminated) ->
		console.log "ForecastAnalysis constructed"
		overall_answer = true # Should the user fly today? Let's start positive and falsify it if necessary
		currently = raw_data.currently # For this version, we'll only be checking the current weather
		today = raw_data.daily.data[0]

		responses = []

		responses.push @check_precipitation(currently, waterproof)
		responses.push @check_windspeed(currently, fixed_wing)
		responses.push @check_daylight(today, illuminated)

		@update_interface(raw_data, responses)

	check_daylight: (today, illuminated) ->
		result = true
		reason = ""

		if illuminated
			result =  true # light doesn't matter so much
			reason = "You've got lights, you can fly in a cave with no lights!"
		else
			result = today.sunriseTime < Date.now() && Date.now() < today.sunsetTime
			if result
				reason = "You've got sunlight... for now"
			else
				reason = "The sun has set and you have no lights"

		return {result: result, reason: reason}


	check_windspeed: (data, fixed_wing) ->
		result = true
		reason = ""

		if fixed_wing
			result = data.windSpeed < @acceptable_fixed_wing_windspeed
		else
			result = data.windSpeed < @acceptable_multi_rotor_windspeed

		if result
			reason = "The winds aren't too fast"
		else
			reason = "The wind speeds are too damned high!"

		return {result: result, reason: reason}

	check_precipitation: (data, waterproof) ->
		result = true
		reason = ""

		if waterproof
			result = true # If it's waterproof, rain won't hurt it
			reason = "Rain ain't no thing for your aircraft!"
		else
			result = data.precipProbability < @acceptable_precipitation_probability
			if result
				reason = "The chances of rain are small enough to ignore"
			else
				reason = "There's a good chance you'll get rained out"

		return {result: result, reason: reason}

	update_interface: (raw_data, responses) ->

		# aggregate the responses
		aggregate = true
		text_responses = ""
		for response in responses
			response_result = response.result
			text_responses += "<p class='reason "+response.result+"'>"+response.reason+"</p>"
			aggregate = if response_result then aggregate else false
		overall_response = "<p>"+(if aggregate then "Yup! Go fly!" else "You might not want to")+"</p>"

		# Update the answer
		$(@short_answer_selector).html(overall_response+text_responses)

		# Grab the Curent weather element
		$current_weather = $(@current_weather_selector)
		#clear existing things
		$current_weather.children().not('legend').remove()

		# generate some data to simplify the output
		currently = raw_data.currently
		today = raw_data.daily.data[0]
		sunlight = today.sunriseTime < Date.now() && Date.now() < today.sunsetTime
		remaining_sunlight = @milliseconds_to_hours(today.sunsetTime-Date.now())

		# Output the salient flying details
		$current_weather
			.append('<p>Summary: '+currently.summary+'</p>')
			.append('<p>Temperature: '+Math.round(currently.temperature)+'F</p>')
			.append('<p>Precipitation: %'+(currently.precipProbability*100)+'</p>')
			.append('<p>Wind Speed: '+Math.round(currently.windSpeed)+'mph</p>')
			.append('<p>Sunlight: '+(if sunlight then "Yup, you've got "+remaining_sunlight+" hours to fly" else "Nope")+'</p>')

			# .append('<p>Summary: '+data.+'</p>')

	milliseconds_to_hours: (seconds) ->
		(seconds/1000/60/60).toFixed(2)
