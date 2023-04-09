/*
 * Copyright (C) 2022  ikozyris
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
import QtWebEngine 1.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

Page {
    id: mainPage
    anchors.fill: parent

    header: PageHeader {  
        id: pageHeader   
        TextField {
        id: textFieldInput
	        anchors {
	            top: parent.top
	            left: parent.left
        		topMargin: units.gu(2)
	            leftMargin: units.gu(2)
        	}
        	placeholderText: i18n.tr('website')
            onAccepted: {
                webview.visible = true,
                webview.reload()
            }
        }
        ActionBar {
	        anchors {
        	    top: parent.top
	    	    right: parent.right
	            topMargin: units.gu(1)
        	    rightMargin: units.gu(1)
	        }
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
                },
                Action {
                    iconName: "settings"
	    	        text: i18n.tr("Settings")
                    onTriggered: mainView.showSettings()
                },

                Action {
	            	iconName: "info"
	    	        text: i18n.tr("About")
                    onTriggered: pStack.push(Qt.resolvedUrl("About.qml"));
        	    }
	        ]
        }
    }

    WebEngineView {
        id: webview
        visible: false
        anchors {
            top: pageHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        	topMargin: units.gu(0)
	        rightMargin: units.gu(0)
        }
        url: "https://" + textFieldInput.text
        zoomFactor: preferences.zoomlevel / 100
        profile: webViewProfile
    }

    WebEngineProfile {
        //for more profile options see https://doc.qt.io/qt-5/qml-qtwebengine-webengineprofile.html
        id: webViewProfile
        persistentCookiesPolicy: WebEngineProfile.NoPersistentCookies; //do NOT store persistent cookies
        httpCacheType: WebEngineProfile.DiskHttpCache; //cache qml content to file
    }
}
