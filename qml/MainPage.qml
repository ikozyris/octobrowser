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

import QtQuick 2.9
//import QtQuick.Controls 2.2
//import Morph.Web 0.1
import QtWebEngine 1.11
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
//import "GetUrl.js" as GetUrl

Page {
    id: mainPage
    anchors.fill: parent

    function isurl(s) {
        var regexp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/
        return regexp.test(s);
    }

    function geturl(text) {
        if (isurl(text)) {
            console.log("String is a valid url")
            console.log(text)
            return text;
        } else {
            var query = "https://duckduckgo.com/?q=" + encodeURIComponent(text);
            console.log("String is a query")
            console.log(query)
            return query;
        }
    }

    header: PageHeader {
        id: pageHeader
        anchors.top: parent.top //if bar is on top
            //anchors.top: preferences.adrpos === 1 ? parent.top  :  undefined
            //anchors.bottom: preferences.adrpos === 1 ? parent.bottom  :  undefined
            //bottom: parent.bottom //if bar is on bottom
            /*states: [
                State {
                    name: "anchorBottom"
                    AnchorChanges {
                        target: pageHeader
                        anchors.top: undefined  //remove the top anchor
                        anchors.bottom: parent.bottom
                    }
                },
                State {
                    name: "anchorTop"
                    AnchorChanges {
                        target: pageHeader
                        anchors.bottom: undefined //remove the bottom anchor
                        anchors.top: parent.top  
                    }
                }
            ]*/
        leadingActionBar {
            numberOfSlots: 3
            actions: [
                Action {
	        		visible: webview.canGoForward ? true : false
                    iconName: "go-next"
	                text: i18n.tr("Forward")
                    onTriggered: webview.goForward()
            	},
                Action {
                    visible: webview.canGoBack ? true : false
	        		iconName: "previous"
	                text: i18n.tr("back")
                    onTriggered: webview.goBack()
            	},
                Action {
                    iconName: webview.loadProgress === 100 ? "reload" : "stop"
	                text: webview.loadProgress === 100 ? "Reload" : "Stop"
                    onTriggered: webview.loadProgress === 100 ? webview.reload() : webview.stop()
                }
            ]
        }

        TextField {
        id: textFieldInput
	        anchors {
	            top: parent.top
                topMargin: units.gu(1)
                left: parent.left
                leftMargin: 0.27*parent.width
                right: parent.right
                rightMargin: 0.11*parent.width
        	}
        	placeholderText: i18n.tr('Enter a URL or a search query')
            inputMethodHints: {
                Qt.ImhNoAutoUppercase,
                Qt.ImhUrlCharactersOnly,
                Qt.ImhNoPredictiveText
            }
            onAccepted: {
                webview.url = geturl(textFieldInput.text),
                webview.visible = true
            }
        }

        trailingActionBar {
            numberOfSlots: 0
            actions: [
                Action {
                    iconName: "settings"
	                text: i18n.tr("Settings")
                    onTriggered: mainView.showSettings()
                },
                 Action {
	            	iconName: "info"
	                text: i18n.tr("About")
                    onTriggered: pStack.push(Qt.resolvedUrl("About.qml"));
                },
                Action {
                    iconName: "help"
                    text: i18n.tr("Help")
                    onTriggered: pStack.push(Qt.resolvedUrl("Help.qml"));
                },
                Action {
                    iconName: "close"
                    text: i18n.tr("Exit")
                    onTriggered: Qt.quit()
                }
	        ]
        }

    }

    WebEngineView {
        id: webview
        visible: false
        anchors {
            top: pageHeader.bottom 
            //top: parent.top //if bar is on bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom 
            //bottom: pageHeader.top //for bottom
        	topMargin: units.gu(0)
	        rightMargin: units.gu(0)
        }/*
        states: [
            State {
            name: "anchorBottom"
                AnchorChanges {
                    target: webview
                    anchors.top: parent.top
                    anchors.bottom: pageHeader.top
                }
            },
            State {
                name: "anchorTop"
                AnchorChanges {
                    target: webview
                    anchors.top: pageHeader.bottom
                    anchors.bottom: parent.bottom
                }
            }
        ]*/
        url: "about:blank"
        zoomFactor: preferences.zoomlevel / 100
        settings.javascriptEnabled: preferences.js
        settings.autoLoadImages: preferences.loadimages
        //settings.webRTCPublicInterfacesOnly: true
        profile: webViewProfile
        onLoadingChanged: {
            if(loadRequest.errorString)
                console.error(loadRequest.errorString);
            else
                console.info("Load web page successfull");
        }
    }

    WebEngineProfile {
        //for more profile options see https://doc.qt.io/qt-5/qml-qtwebengine-webengineprofile.html
        id: webViewProfile
        persistentCookiesPolicy: WebEngineProfile.NoPersistentCookies; //do NOT store persistent cookies
        httpCacheType: WebEngineProfile.DiskHttpCache; //cache qml content to file
        httpUserAgent: preferences.cmuseragent
    }
}
