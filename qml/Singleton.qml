pragma Singleton

import QtQuick 2.12
import Qt.labs.settings 1.0

Item {
	// Tab list
	property var tabs: [""];
	// workaround since TextField does not
	// detect changes in above list 
	property url currtab: "";
	property int tabNum: 0;
	property bool tabVisibility: false;

/*	Settings {
		id: kept
		property var tabsk: []
	}

	// TODO: cannot access
	Component.onCompleted: if (prefs.ktabs) tabs = kept.tabsk 
	Component.onDestruction: if (prefs.ktabs) kept.tabsk = tabs 
*/
}
