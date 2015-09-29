$ ->
	console.log "You should probably make this do something. Something impressive preferably."
	window.fioi = new ForecastIOInterface()

	# Bind submit listener
	$('#submit').on 'click', (e) ->
		e.preventDefault()
		e.stopPropagation()
		# Get lat/lng
		lat = $('#lat').val()
		lng = $('#lng').val()
		fioi.query lat,lng, (data) ->
			console.log "GOT SOME DATA: ", data