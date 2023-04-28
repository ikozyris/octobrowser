function setFullscreen(fullscreen) {
	if (fullscreen) {
	    if (window.visibility != Page.FullScreen) {
		window.visibility = Page.FullScreen
	    }
	} else {
	    window.visibility = Window.Windowed
	}
}

function lookslikeurl(s) {
	var regexp = /^(?:(?:(?:[a-zA-z\-]+)\:\/{1,3})?(?:[a-zA-Z0-9])(?:[a-zA-Z0-9\-\.]){1,61}(?:\.[a-zA-Z]{2,})+|\[(?:(?:(?:[a-fA-F0-9]){1,4})(?::(?:[a-fA-F0-9]){1,4}){7}|::1|::)\]|(?:(?:[0-9]{1,3})(?:\.[0-9]{1,3}){3}))(?:\:[0-9]{1,5})?$/;
	return regexp.test(s);
}

function fixurl(string) {
	if (lookslikeurl(string)) {
	    if (preferences.securecontent != true) {
			return "https://" + string;
	    } else {
			return "http://" + string;
	    }
	} else {
	    return "bad";
	}
}

function isurl(s) {
	var regexp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
	return regexp.test(s);
}

function geturl(text) {
	if (isurl(text)) {
	    return text;
	} else {
	    var result = fixurl(text)
	    if (result != "bad") {
			return result;
	    } else {
			var query = "https://duckduckgo.com/?q=" + encodeURIComponent(text);
			return query;
	    }
	}
}