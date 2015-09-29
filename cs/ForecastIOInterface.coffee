window.ForecastIOInterface = class ForecastIOInterface

	# API jawnies
	api_key: "" # What do we say to the god of Accidentally Posting Your API Keys Publicly On The Internet? Not today. 
	api_url: "https://api.forecast.io/forecast/"


	constructor: () ->
		console.log "FIO Interface constructed"

	query: (lat, lng, cbfn) ->
		latitude = String(lat)
		longitude = String(lng)
		debugger
		url = @api_url+@api_key+"/"+latitude+","+longitude
		console.log "Hitting up: ", url
		data = undefined
		# $.ajax 

		# call callback
		if typeof(cbfn) == "function"
			cbfn(data)