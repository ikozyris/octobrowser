pragma Singleton

import QtQuick 2.9

Item {
	function append(string) {
		array.push(string)
	}
	
	function sizeof() {
		return array.lenght
	}
	property var array: [""];
}