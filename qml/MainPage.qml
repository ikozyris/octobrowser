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
import Qt.labs.settings 1.0
import Qt.labs.platform 1.0
import Ubuntu.DownloadManager 1.2
import Ubuntu.Components.Popups 1.3

import "qrc:///qml/Utils.js" as JS
import "qrc:///qml/"

Page {
    id: mainPage
    anchors.fill: parent

    property string barposition: prefs.adrpos == 1 ? "bottom" : "top";
    property bool canshow: JS.canshow(webview.loadProgress)

    header: Header {id: pageHeader}
    WebViewer {
        id: webview
        anchors {
            top: pageHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        states: [
            State {
                name: "bottom"
                AnchorChanges {
                    target: webview
                    anchors.top: parent.top
                    anchors.bottom: pageHeader.top
                }
            },
            State {
                name: "fullscreen"
                AnchorChanges {
                    target: webview
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                }
            },
            State {
                name: "top"
                AnchorChanges {
                    target: webview
                    anchors.top: pageHeader.bottom
                    anchors.bottom: parent.bottom
                }
            }
        ]
    }

    ProgressBar {
        anchors {
            top: pageHeader.bottom
            left: parent.left
            right: parent.right
        }
        states: [
            State {
                name: "bottom"
                AnchorChanges {
                    target: webview
                    anchors.top: undefined
                    anchors.bottom: pageHeader.top
                }
            },
            State {
                name: "top"
                AnchorChanges {
                    target: webview
                    anchors.bottom: undefined
                    anchors.top: pageHeader.bottom
                }
            }
        ]
        showProgressPercentage: false
        value: webview.loadProgress / 100
        visible: canshow
    }

    Rectangle {
        id: webViewPlaceholder
        anchors {
            top: pageHeader.bottom
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
                    anchors.bottom: pageHeader.top
                }
            },
            State {
                name: "top"
                AnchorChanges {
                    target: webViewPlaceholder
                    anchors.top: pageHeader.bottom
                    anchors.bottom: parent.bottom
                }
            }
        ]
        color: "#3A3A3A"
        visible: !MyTabs.tabVisibility // opposite
        Label {
            id: placeholdertext
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: i18n.tr("Welcome to <i>Octopus Browser</i>, <br> a fast & customizable browser.")
            textSize: Label.Large
            wrapMode: Text.Wrap
            color: "white"
            anchors.centerIn: parent
        }
        UbuntuShape {
            width: units.gu(12); height: units.gu(12)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: placeholdertext.top
            radius: "medium"
            image: Image {
                source: Qt.resolvedUrl("/assets/logo.svg")
            }
        }
    }

    Component.onCompleted: {
        barposition: prefs.adrpos == 1 ? "bottom" : "top";
        pageHeader.state = barposition;
        webview.state = barposition;
        webViewPlaceholder.state = barposition;
    }
}
