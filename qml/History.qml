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
//import QtQuick.Window 2.12
//import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import Ubuntu.Components 1.3

import "qrc:///qml/"
<<<<<<< HEAD
import "qrc:///qml/Utils.js" as JS
=======
import "qrc:///qml/utils.js" as JS
>>>>>>> 95b5829fc0a86edfbe3d12f668fa77ca4cca64b5

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
    UbuntuListView {
        anchors {
            fill: parent
		    top: historyPage.header.bottom
            topMargin: units.gu(6)
            leftMargin: units.gu(0.5)
            rightMargin: units.gu(0.5)
        }
        model: history.count // (array.lenght does not work)
        delegate: ListItem {
            //do not calculate this every time
            readonly property int curr: history.count - index
            //TODO: share this action as an optimization?
            leadingActions: ListItemActions {
                id: leading
                actions: Action {
                    iconName: "delete"
                    onTriggered: JS.delIndex(curr)
                }
            }
            Label {
                text: i18n.tr("On ") + history.dates[curr] + ":\n" + history.urls[curr]
                wrapMode: Text.WrapAnywhere
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }
            trailingActions: ListItemActions {
                actions: Action {
                    iconName: "external-link"
                    onTriggered: {
                        MyTabs.currtab = history.urls[curr];
                        pStack.pop();
                    }
                }
            }
        } 
    }/*
    Loader {
        sourceComponent: list
    }*/
    //Component.onCompleted: console.log(history.count + " or " + history.urls.lenght)
}
