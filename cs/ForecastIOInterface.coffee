window.ForecastIOInterface = class ForecastIOInterface

	# API jawnies
	api_key: "3587b2d6d9318e9df488d17a2f41c088" # What do we say to the god of Accidentally Posting Your API Keys Publicly On The Internet? Not today. 
	api_url: "https://api.forecast.io/forecast/"

	constructor: () ->
		console.log "FIO Interface constructed"

	query: (lat, lng, cbfn) ->
		latitude = String(lat)
		longitude = String(lng)
		url = @api_url+@api_key+"/"+latitude+","+longitude
		$.ajax
			type: "GET"
			url: url
			dataType: "jsonp"
			success: (data) =>
				# call callback
				if typeof(cbfn) == "function"
					cbfn(data)
			error: (uhh) =>
				if typeof(cbfn) == "function"
					cbfn(undefined)
