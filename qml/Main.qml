/*
 * Copyright (C) 2022  Ioannis Kozyris
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

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'octobrowser.ikozyris'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)
        
    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('Octopus Browser')
        }
        



        TextField {
    	id: textFieldInput
	        anchors {
		        top: header.bottom
		        left: parent.left
        		topMargin: units.gu(2)
		        leftMargin: units.gu(2)
        	}
        	placeholderText: i18n.tr('www.kozyweb.tk')
        }

        Button {
	    id: buttonAdd
	        anchors {
	        	top: header.bottom
	        	right: parent.right
        		topMargin: units.gu(2)
	        	rightMargin: units.gu(2)
        	}
        	text: i18n.tr('Go!')
        	onClicked: console.log(i18n.tr(textFieldInput.text))
        }   


        }

                        
    
    WebEngineView {
        id: webview
        anchors {
            top: header.bottom
	        right: parent.right
        	topMargin: units.gu(4)
	        rightMargin: units.gu(2)
        }
        url: (textFieldInput.text)
        zoomFactor: 0.75 //scales the webpage on the device, range allowed from 0.25 to 5.0; the default factor is 1.0
        profile: webViewProfile
    }

    WebEngineProfile {
        //for more profile options see https://doc.qt.io/qt-5/qml-qtwebengine-webengineprofile.html
        id: webViewProfile
        persistentCookiesPolicy: WebEngineProfile.NoPersistentCookies; //do NOT store persistent cookies
        httpCacheType: WebEngineProfile.DiskHttpCache; //cache qml content to file
    }
        
   
} 

