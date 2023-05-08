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
//import QtGraphicalEffects 1.12
import QtQuick.Controls 2.2
//import Morph.Web 0.1
import QtWebEngine 1.11
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import Qt.labs.platform 1.0
import Ubuntu.DownloadManager 1.2
import Ubuntu.Components.Popups 1.3

import "qrc:///qml/Utils.js" as JS
import "qrc:///qml/Dialogs/" as DL

import DownloadInterceptor 1.0

Page {
    id: mainPage
    anchors.fill: parent
    //visible: true
    
    property string barposition: preferences.adrpos == 1 ? "bottom" : "top";
    property bool canshow: JS.canshow(webview.loadProgress)

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
                    iconName: webview.loadProgress == 100 ? "reload" : "stop"
                    onTriggered: webview.loadProgress == 100 ? webview.reload() : webview.stop()
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
            inputMethodHints: Qt.ImhUrlCharactersOnly | Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
            onAccepted: {
                MyTabs.currtab = JS.geturl(textFieldInput.text),
                webview.visible = true
            }
        }

        trailingActionBar {
            numberOfSlots: 0
            actions: [
                Action {
                    iconName: "browser-tabs"
                    text: i18n.tr("Manage Tabs")
                    onTriggered: pStack.push(Qt.resolvedUrl("TabView.qml"));
                },
                Action {
                    iconName: "document-save"
                    text: i18n.tr("Downloads")
                    onTriggered: pStack.push(Qt.resolvedUrl("Download.qml"));
                },
                Action {
                    iconName: "settings"
	                text: i18n.tr("Settings")
                    onTriggered: mainView.showSettings();
                },
                Action {
		    iconName: "history"
	            text: i18n.tr("History")
                    onTriggered: pStack.push(Qt.resolvedUrl("History.qml"));
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
                }/*,
                Action {
                    iconName: "close"
                    text: i18n.tr("Exit")
                    onTriggered: Qt.quit()
                }*/
	    ]
        }
    }

    ProgressBar {
        anchors {
            top: pageHeader.bottom
            left: parent.left
            right: parent.right
        }
        showProgressPercentage: false
        value: webview.loadProgress / 100
        visible: canshow
    }

    Rectangle {
        id: webViewPlaceholder
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        color: "#3A3A3A"
        visible: webview.visible ? false : true
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
                source: Qt.resolvedUrl("qrc:///assets/logo.svg")
            }
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
	    topMargin: canshow ? units.gu(0.5) : units.gu(0)
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
        url: MyTabs.currtab
        zoomFactor: preferences.zoomlevel / 100                         // custom zoom factor
        settings.javascriptEnabled: preferences.js                      // enable javascipt
        settings.autoLoadImages: preferences.loadimages                 // autoload images
        settings.webRTCPublicInterfacesOnly: preferences.webrtc         // setting to true creates leaks
        settings.pluginsEnabled: true                                   // workaround for pdf
        settings.playbackRequiresUserGesture: preferences.autoplay      // autoplay video
        settings.pdfViewerEnabled: true                                 // enable pdf viewer
        settings.showScrollBars: false                                  // do not show scroll bars
        settings.allowRunningInsecureContent: preferences.securecontent // InSecure content
        settings.fullScreenSupportEnabled: true
        settings.dnsPrefetchEnabled: true
        settings.touchIconsEnabled: true
        profile: webViewProfile
        onFullScreenRequested: function(request) {
            if (request.toggleOn) {
                pageHeader.visible = false;
                webview.state = "fullscreen";
                window.showFullScreen();
            } else {
                window.showNormal();
                webview.state = barposition;
                pageHeader.visible = true;
            }
            request.accept();
        }
        onLoadingChanged: {
            //gc() //garbage collection
            textFieldInput.text = webview.url
            if(loadRequest.errorString)
                console.error(loadRequest.errorString);
            else {
                history.urls.push(webview.url);
                history.dates.push(new Date());
                history.count = history.count + 1; 
            }
        }
        backgroundColor: "grey"
    }

    WebEngineProfile {
        //for more profile options see https://doc.qt.io/qt-5/qml-qtwebengine-webengineprofile.html
        id: webViewProfile
        persistentCookiesPolicy: WebEngineProfile.AllowPersistentCookies; //store persistent cookies
        httpCacheType: WebEngineProfile.DiskHttpCache;                 //cache qml content to file
        httpUserAgent: preferences.cmuseragent;                        //custom UA
        offTheRecord: false
        onDownloadRequested: {
            var fileUrl = StandardPaths.writableLocation(StandardPaths.AppDataLocation) + "/Downloads/" + download.downloadFileName;
            var request = new XMLHttpRequest();
            request.open("PUT", fileUrl, false);
            request.send(decodeURIComponent(download.url.toString().replace("data:text/plain;,", "")));
            PopupUtils.open(DL.downloadDialog, mainPage, { "fileName" : download.downloadFileName})
        }
    }

    Component.onCompleted: {
        barposition: preferences.adrpos == 1 ? "bottom" : "top";
        pageHeader.state = barposition;
        webview.state = barposition;
        //gc();
    }

    Component.onDestruction: {
        webview.stop(),
        webViewProfile.clearHttpCache(),
        gc(),
        console.log("Goodbye")
    }
}
