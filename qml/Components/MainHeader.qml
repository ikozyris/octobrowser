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
import QtQuick.Controls 2.12 as QQC2

import "qrc:///qml/Utils.js" as JS
import ".."

PageHeader {
    id: pageHeader

    property alias textbar: textFieldInput.text
    signal message(string msg)

    anchors.top: parent.top //if bar is on top
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
                onTriggered: webview.loadProgress === 100 ? webview.reload() : webview.stop();
            }
        ]
    }
    //QQC2.TextField {
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
        states: [
            State {
                name: "focused"
                AnchorChanges {
                    target: textFieldInput
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                }
            },
            State {
                name: "normal"
                AnchorChanges {
                    target: textFieldInput
                    anchors {
                        left: leadingActionBar.right
                        right: trailingActionBar.left
                    }
                }
            }
        ]/*
        background: Rectangle {
            id: backcolor
            anchors.fill: parent
            color: Theme.name === "Ubuntu.Components.Themes.SuruDark" ? "#3A3A3A" : "lightgray"
            radius: 10
        }*/
        transitions: Transition {
            // smoothly reanchor
            AnchorAnimation { duration: 100 }
        }
        placeholderText: i18n.tr("Enter a URL or a search query")
        inputMethodHints: Qt.ImhUrlCharactersOnly | Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
        onActiveFocusChanged: {
            if (activeFocus) {
                state = "focused"
                selectAll()
            } else {
                state = "normal"
            }
        }
        onAccepted: {
            //MyTabs.tabs[MyTabs.tabNum] = JS.geturl(textFieldInput.text)
            MyTabs.currtab = JS.buildSearchUrl(textFieldInput.text)
            MyTabs.tabVisibility = true
            state = "normal"
        }
    }
    trailingActionBar {
        numberOfSlots: 2
        actions: [
            Action {
                iconName: "browser-tabs"
                text: i18n.tr("Manage Tabs")
                onTriggered: pStack.push(Qt.resolvedUrl("/qml/TabsView.qml"))
            },
            Action {
                iconName: "settings"
                text: i18n.tr("Settings")
                onTriggered: pStack.push(Qt.resolvedUrl("/qml/SettingsView.qml"))
            },
            Action {
                iconName: "history"
                text: i18n.tr("History")
                onTriggered: pStack.push(Qt.resolvedUrl("/qml/HistoryView.qml"))
            },
            Action {
                iconName: "find"
                text: i18n.tr("Find in page")
                onTriggered: pageHeader.message("find")
            },
            Action {
                iconName: "info"
                text: i18n.tr("About")
                onTriggered: pStack.push(Qt.resolvedUrl("/qml/About.qml"))
            },
            Action {
                iconName: "help"
                text: i18n.tr("Help")
                onTriggered: pStack.push(Qt.resolvedUrl("/qml/Help.qml"))
            }
        ]
    }
}
