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

* Have the app take daylight into account
* Have the app propose the best time in the day to fly

### Authors Notes

* In the interest of saving time, I decided to do without detailed error reporting. I did make some attempts to error-proof the interface, but it's not impossible to break. 
* Yes, I like fieldsets. Deal with it.
* 