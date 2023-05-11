/*
 * Copyright (C) 2023  ikozyris
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * octobrowser is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * this file is part of Octopus Browser (octobrowser)
 */

import QtQuick 2.12
//import QtQuick.Window 2.12
//import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import Ubuntu.Components 1.3

import "qrc:///qml/"

Page {
	id: historyPage
    
    function clearhistory() {
        history.urls = [];
        history.dates = [];
        history.count = 0;
    }

	header: PageHeader {
        title: i18n.tr("History")
        trailingActionBar.actions: Action {
            iconName: "delete"
            text: i18n.tr("Clear history")
            onTriggered: clearhistory()
        }
    }

    Loader {
        source: Qt.resolvedUrl("HistoryView.qml")
        asynchronous: true
        anchors {
            fill: parent
	        top: historyPage.header.bottom
            topMargin: units.gu(6)
            leftMargin: units.gu(0.5)
            rightMargin: units.gu(0.5)
        }
    }
    //Component.onCompleted: console.log(history.count + " or " + history.urls.lenght)
}
