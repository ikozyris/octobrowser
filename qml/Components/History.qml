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

import Ubuntu.Components 1.3
import QtQuick 2.12

import "qrc:///qml/Utils.js" as JS
import "qrc:///qml/"

UbuntuListView {
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
            actions: [
                Action {
                    iconName: "external-link"
                    onTriggered: {
                        MyTabs.currtab = history.urls[curr];
                        //mainPage.webview.url = MyTabs.currtab;
                        MyTabs.tabVisibility = true;
                        pStack.pop();
                    }
                },
                Action {
                    iconName: "edit-copy"
                    onTriggered: Clipboard.push(history.urls[curr])
                }
            ]
        }
    }
}
