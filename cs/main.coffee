$ ->
	console.log "You should probably make this do something. Something impressive preferably."
	window.fioi = new ForecastIOInterface()
	window.analysis = undefined

	# Bind submit listener
	$('#submit').on 'click', (e) ->
		$(@).attr('disabled', true)
		e.preventDefault()
		e.stopPropagation()
		# Get lat/lng
		lat = $('#lat').val()
		lng = $('#lng').val()
		fioi.query lat,lng, (data) =>
			$(@).attr('disabled', false)
			if data
				waterproof = $('#waterproof').is(':checked')
				fixed_wing = if $('input[name="aircraft_type"]:checked').val() == "fixed" then true else false
				illuminated = $('#illuminated').is(':checked')
				window.analysis = new ForecastAnalysis(data, waterproof, fixed_wing, illuminated)
			else
				alert "You broke it. Why did you do that? Stop it."