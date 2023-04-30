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
 */

import QtQuick 2.12
import QtQuick.Window 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import Ubuntu.Components 1.3

//import MyHistory 0.1
import "qrc:///qml/"

Page {
	id: historyPage
	header: PageHeader {
		id: head
        title: i18n.tr("History")
    }

    Component {
        id: itemDelegate
        Label {
            // do not load NULL entries
            text: MyHistory.array[index] != null ? MyHistory.array[index] : null
		}
    }

    ListView {
        anchors.fill: parent
		anchors.topMargin: units.gu(6)
		anchors.leftMargin: units.gu(2)
        model: 42 // DILLEMA: 1337 or 42, entries to be loaded
        delegate: itemDelegate
    }
    //Component.onCompleted: console.log(MyHistory.sizeof())
}