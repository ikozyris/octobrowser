import QtQuick 2.12
import Ubuntu.Components 1.3

PageHeader {
	id: findHeader

    signal message(string msg)

	leadingActionBar {
        actions: Action {
		    iconName: "clear"
            onTriggered: findHeader.message("unfind")
        }
	}

    TextField {
        id: findTextbar
        anchors.left: leadingActionBar.right
        onAccepted: {
            webview.findText(findTextbar.text, function(matchCount) {
                if (matchCount > 0)
                    console.log("tokens found:", matchCount);
            });
        }
    }
    trailingActionBar {
        actions: Action {
            iconName: "go-next"
        }
    }
}