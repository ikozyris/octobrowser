import QtQuick 2.12
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem

Rectangle {
	id: suggestions
    radius: 10
    signal activated(string text)
    color: theme.palette.normal.background
    border.color: theme.palette.normal.raised
    height: 0 // height will be dynamically changed
	ListView {
        id: suggList
		anchors.fill: parent
        model: results
        delegate: ListItem.Base {
			height: units.gu(3) 
            // disable focus handling
            activeFocusOnPress: false

            Label {
                text: modelData.title
				//fontSize: "small"
            }
            onClicked: activated(modelData.title)
            Component.onCompleted: suggestions.height = units.gu((index + 1) * 3)
        }
    }
    property var results
    property var xhr: null
    function get(text) {
        //console.log("input: " + text) 
        if (xhr === null) {
            xhr = new XMLHttpRequest()
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    //console.log("received: " + xhr.responseText)
                    results = parseResponse(xhr.responseText)
                    //console.log("parsed: " + results)
                }
            }
        }
        //console.log("encoded: " + encodeURIComponent(text))
        if (prefs.srchEngine === 0)
            xhr.open("GET", "https://ac.duckduckgo.com/ac/?q=" + encodeURIComponent(text) + "&type=list");
        else
            xhr.open("GET", "https://www.google.com/complete/search?client=firefox&q=" + encodeURIComponent(text));
        xhr.send();
    }
    function abort() {
        if (xhr) xhr.abort()
    }
	function parseResponse(response) {
        try {
            var data = JSON.parse(response)
        } catch (error) {
            console.log("error: " + error)
            return []
        }

        if (data.length > 1) {
            return data[1].map(function(result) {
                return {
                    title: result
                    //url: 
                }
            })
        } else return []
    }
}