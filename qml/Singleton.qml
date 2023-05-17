pragma Singleton

import QtQuick 2.12

Item {
	// Tab list
	property var tabs: [""];
	// workaround since textField does not
	// detect changes in above list 
	property url currtab: "";
	property int tabNum: 0;
	property bool tabVisibility: false;
	// URL forwarded from history
	property url display: "";
}
