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

PageHeader {
    id: pageHeader

    property alias textbar: textFieldInput.text

    anchors.top: parent.top //if bar is on top
    states: [
        State {
            name: "bottom"
            AnchorChanges {
                target: pageHeader
                anchors.top: undefined  //remove the top anchor
                anchors.bottom: parent.bottom
            }
        },
        State {
            name: "top"
            AnchorChanges {
                target: pageHeader
                anchors.bottom: undefined //remove the bottom anchor
                anchors.top: parent.top
            }
        }
    ]
    leadingActionBar {
        numberOfSlots: 3
        actions: [
            Action {
                visible: webview.canGoForward
                iconName: "go-next"
                onTriggered: webview.goForward();
            },
            Action {
                visible: webview.canGoBack
                iconName: "previous"
                onTriggered: webview.goBack();
            },
            Action {
                visible: MyTabs.currtab != ""
                iconName: webview.loadProgress === 100 ? "reload" : "stop"
                onTriggered: webview.loadProgress === 100 ? webview.reload() : webview.stop()
            }
        ]
    }
    TextField {
        id: textFieldInput
        anchors {
            top: parent.top
            topMargin: units.gu(1)
            left: leadingActionBar.right
            leftMargin: units.gu(1)
            right: trailingActionBar.left
            rightMargin: units.gu(1)
	    }
        placeholderText: i18n.tr('Enter a URL or a search query')
        inputMethodHints: Qt.ImhUrlCharactersOnly | Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
        onAccepted: {
            //MyTabs.tabs[MyTabs.tabNum] = JS.geturl(textFieldInput.text)
            MyTabs.currtab = JS.geturl(textFieldInput.text)
            MyTabs.tabVisibility = true
        }
    }
    trailingActionBar {
        numberOfSlots: 2
        actions: [
            Action {
                iconName: "add"
                text: i18n.tr("New Tab")
                onTriggered: JS.newtab()
            },
            Action {
                iconName: "browser-tabs"
                text: i18n.tr("Manage Tabs")
                onTriggered: pStack.push(Qt.resolvedUrl("TabsView.qml"))
            },
            Action {
                iconName: "document-save"
                text: i18n.tr("Manual download")
                onTriggered: pStack.push(Qt.resolvedUrl("Download.qml"))
            },
            Action {
                iconName: "settings"
                text: i18n.tr("Settings")
                onTriggered: mainView.showSettings()
            },
            Action {
                iconName: "history"
                text: i18n.tr("History")
                onTriggered: pStack.push(Qt.resolvedUrl("History.qml"))
            },
            Action {
                iconName: "info"
                text: i18n.tr("About")
                onTriggered: pStack.push(Qt.resolvedUrl("About.qml"))
            },
            Action {
                iconName: "help"
                text: i18n.tr("Help")
                onTriggered: pStack.push(Qt.resolvedUrl("Help.qml"))
            }
        ]
    }
}
