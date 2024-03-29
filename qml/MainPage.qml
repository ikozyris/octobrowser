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
import QtQuick.Controls 2.2
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Ubuntu.Components.Popups 1.3

import "qrc:///qml/Utils.js" as JS
import "qrc:///qml/"

Page {
    id: mainPage
    anchors.fill: parent

    property string barposition: prefs.adrpos === 1 ? "bottom" : "top";
    //property bool canshow: JS.canshow(webview.loadProgress)
    property alias pageHeader: headerLoader.item
    header: Loader { 
        id: headerLoader
        z: 95
        asynchronous: true
        source: Qt.resolvedUrl("/qml/Components/MainHeader.qml")
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        states: [
            State {
                name: "bottom"
                AnchorChanges {
                    target: headerLoader
                    anchors.top: undefined  //remove the top anchor
                    anchors.bottom: parent.bottom
                }
            },
            State {
                name: "top"
                AnchorChanges {
                    target: headerLoader
                    anchors.bottom: undefined //remove the bottom anchor
                    anchors.top: parent.top
                }
            }
        ]    
    }
    // Receive messages from header
    Connections {
        target: headerLoader.item
        onMessage: {
            // enter find mode
            if (msg === "find")
                headerLoader.setSource(Qt.resolvedUrl("/qml/Components/Find.qml"))
            // exit find mode
            else if (msg === "unfind")
                headerLoader.setSource(Qt.resolvedUrl("/qml/Components/MainHeader.qml"))
        }
    }
    Connections {
        target: srchSugg.item
        onActivated: {
            webview.url = JS.buildSearchUrl(text)
            srchSugg.visible = false
            MyTabs.tabVisibility = true
            //pageHeader.textFieldInput.focus = false
        }
    }

    Loader {
        id: srchSugg
        source: Qt.resolvedUrl("SearchSuggestionList.qml")
        z: 90 //appear on top
        //visible: pageHeader.textbar != "" && pageHeader.textFieldInput.focus === true
        anchors {
            margins: units.gu(0.8)
            top: header.bottom
            left: parent.left
            right: parent.right
        }
        states: [
            State {
                name: "bottom"
                AnchorChanges {
                    target: srchSugg
                    anchors.top: undefined
                    anchors.bottom: header.top
                }
            },
            State {
                name: "top"
                AnchorChanges {
                    target: srchSugg
                    anchors.bottom: undefined
                    anchors.top: header.bottom
                }
            }
        ]
    }

    property alias webview: webviewLoader.item
    Loader {
        id: webviewLoader
        z: 80
        //asynchronous: true
        source: Qt.resolvedUrl("/qml/WebViewer.qml")
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        states: [
            State {
                name: "bottom"
                AnchorChanges {
                    target: webviewLoader
                    anchors.top: parent.top
                    anchors.bottom: header.top
                }
            },
            State {
                name: "fullscreen"
                AnchorChanges {
                    target: webviewLoader
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                }
            },
            State {
                name: "top"
                AnchorChanges {
                    target: webviewLoader
                    anchors.top: header.bottom
                    anchors.bottom: parent.bottom
                }
            }
        ]
    }

    ProgressBar {
        z: 90
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
        }
        states: [
            State {
                name: "bottom"
                AnchorChanges {
                    target: webviewLoader
                    anchors.top: undefined
                    anchors.bottom: header.top
                }
            },
            State {
                name: "top"
                AnchorChanges {
                    target: webviewLoader
                    anchors.bottom: undefined
                    anchors.top: header.bottom
                }
            }
        ]
        showProgressPercentage: false
        value: webview.loadProgress / 100
        visible: JS.canshow(webview.loadProgress)
    }

    Loader {
        id: webViewPlaceholder
        asynchronous: true
        z: 30
        source: Qt.resolvedUrl("/qml/Components/WebViewPlaceholder.qml")
        visible: !MyTabs.tabVisibility
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        states: [
            State {
                name: "bottom"
                AnchorChanges {
                    target: webViewPlaceholder
                    anchors.top: parent.top
                    anchors.bottom: header.top
                }
            },
            State {
                name: "top"
                AnchorChanges {
                    target: webViewPlaceholder
                    anchors.top: header.bottom
                    anchors.bottom: parent.bottom
                }
            }
        ]
    }

    Component.onCompleted: {
        //console.log("MainPage loaded")
        // TODO: maybe do this asynchronously?
        barposition: prefs.adrpos === 1 ? "bottom" : "top"
        headerLoader.state = barposition
        webviewLoader.state = barposition
        webViewPlaceholder.state = barposition
        srchSugg.state = barposition
    }
}
