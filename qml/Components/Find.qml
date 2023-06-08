import QtQuick 2.12
import Ubuntu.Components 1.3
import QtWebEngine 1.7

import ".."
PageHeader {
	id: findHeader

    signal message(string msg)

	leadingActionBar {
        actions: Action {
		    iconName: "clear"
            onTriggered: {
                // clear highlights
                webview.findText("")
                findHeader.message("unfind")
            }
        }
	}

    TextField {
        id: findTextbar
        anchors.left: leadingActionBar.right
        onAccepted: {
            webview.findText(findTextbar.text, 
                            WebEngineView.FindCaseInsensitively,
                            function (matchCount) {
                                Find.totalFound = matchCount;}
                            ); 
            foundLoader.active = true;
        }
    }
    // TODO: this is just a workaround
    Loader {
        id: foundLoader
        // do not load
        active: false
        anchors.left: findTextbar.right
        sourceComponent: Label {
            text: Find.activeFound + " / " + Find.totalFound
        }
    }
    trailingActionBar {
        actions: [
            Action {
                iconName: "go-next"
                onTriggered: {
                    webview.findText(findTextbar.text)
                }
            },
            Action {
                iconName: "go-previous"
                onTriggered: {
                    webview.findText(findTextbar.text, WebEngineView.FindBackward)
                }
            }
        ]
    }
}