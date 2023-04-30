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
import QtQuick.Controls 2.2
//import Morph.Web 0.1
import QtWebEngine 1.11
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import "qrc:///qml/utils.js" as JS
//import "qrc:///qml/"

Page {
    id: mainPage
    anchors.fill: parent
    visible: true

    property string barposition: preferences.adrpos === 1 ? "bottom" : "top";

    header: PageHeader {
        id: pageHeader
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
            
        	placeholderText: i18n.tr('Enter a URL or a search query')/*
            inputMethodHints: {
                Qt.ImhNoAutoUppercase,
                Qt.ImhUrlCharactersOnly,
                Qt.ImhNoPredictiveText
            }*/
            inputMethodHints: Qt.ImhUrlCharactersOnly
            onAccepted: {
                webview.url = JS.geturl(textFieldInput.text),
                webview.visible = true
            }
        }

        trailingActionBar {
            numberOfSlots: 0
            actions: [
                Action {
                    iconName: "settings"
	                text: i18n.tr("Settings")
                    onTriggered: mainView.showSettings();
                },
                Action {
	            	iconName: "history"
	                text: i18n.tr("History")
                    onTriggered: mainView.showHistory();
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
//    WebView {
        id: webview
        visible: false
        anchors {
            top: pageHeader.bottom //parent.top //if bar is on bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom //pageHeader.top //for bottom
        	topMargin: units.gu(0)
	        rightMargin: units.gu(0)
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
                name: "top"
                AnchorChanges {
                    target: webview
                    anchors.top: pageHeader.bottom
                    anchors.bottom: parent.bottom
                }
            }
        ]
        url: ""
        zoomFactor: preferences.zoomlevel / 100                         // custom zoom factor
        settings.javascriptEnabled: preferences.js                      // enable javascipt
        settings.autoLoadImages: preferences.loadimages                 // autoload images
        settings.webRTCPublicInterfacesOnly: preferences.webrtc         // webrtc
        settings.pluginsEnabled: true
        settings.pdfViewerEnabled: true                                 // enable pdf viewer
        //settings.showScrollBars: false                                  // do not show scroll bars
        settings.allowRunningInsecureContent: preferences.securecontent // InSecure content
        settings.fullScreenSupportEnabled: true
        settings.dnsPrefetchEnabled: true
        profile: webViewProfile
//        context: webcontext 
        onFullScreenRequested: function(request) {
            if (request.toggleOn) {
               window.showFullScreen();
            } else {
                window.showNormal();
            }
            request.accept();
        }

        onLoadingChanged: {
            //gc() //garbage collection
            textFieldInput.text = webview.url
            if(loadRequest.errorString)
                console.error(loadRequest.errorString);
            else
                history.array.push(webview.url)
                //MyHistory.array.push(textFieldInput.text)
        }
    } 

    WebEngineProfile {
        //for more profile options see https://doc.qt.io/qt-5/qml-qtwebengine-webengineprofile.html
        id: webViewProfile
        //persistentCookiesPolicy: WebEngineProfile.NoPersistentCookies; //do NOT store persistent cookies
        httpCacheType: WebEngineProfile.DiskHttpCache;                 //cache qml content to file
        httpUserAgent: preferences.cmuseragent;                        //custom UA
    }/*
    WebContext {
        id: webcontext
        userAgent: preferences.cmuseragent
    }*/

    Component.onCompleted: {
        barposition: preferences.adrpos === 1 ? "bottom" : "top";
        pageHeader.state = barposition;
        webview.state = barposition;
        //console.log(barposition);
    }

    Component.onDestruction: {
        webview.stop(),
        console.log("Goodbye")
    }
}
