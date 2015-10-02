##About

This is a simple single-page app designed to let drone pilots determine if the weather is suitable for flying at a given geo location. 

This app will be written using jQuery, HAML, SASS, and Coffescript. 


##Usage

To run this app, clone it into your desired directory and open index.html in a browser.  Installation on a web server is just as simple.

To modify this app, you'll need to know SASS, Coffeescript, and HAML, and you'll also need to have the appropriate compilers. As you make changes, you should just need to run the appropriate compilation scripts while in the `/scripts` directory and then reload the page. 

**note: the sass and coffeescript scripts include a watch directive and will keep running until terminated. haml doesn't yet support a watch directive so it needs to be run multiple times**

##Disclaimer

The author of this software does not condone the illegal operation of any recreational aircraft. It is the operators responsibility to know and abide by all local, state, and federal laws. 

##Next Version Features
Should I pursue this app I might have it incorporate the following features in the next version(s)

* Add geolocation so that users can look up the weather by address or by their current location
* Have the app propose the best time of day to fly
* For waterproof aircraft, factor in precipitation intensity 
* Return a probabilistic answers like: "Get out there!", "Probably", "Maybe", "Probably Not", "Only if you want to destroy your aircraft"
* Add in a feature to warn the user if they're near an airports no-fly zone
* Make the mobile experience better

### Authors Notes

* In the interest of saving time, I decided to do without detailed error checking/reporting. I did make some attempts to error-proof the interface, but it's not impossible to break. 
* I could have used a javascript library from Forecast.io, but I figured that might be _too_ easy
* Yes, I know I committed my API key into the repository. It's easy enough to change, and I'm not risking anything in this case.
* Yes, I like fieldsets. Deal with it.