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
import QtWebEngine 1.7
import Ubuntu.Components 1.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
//import "GetUrl.js" as GetUrl

Page {
    id: mainPage
    anchors.fill: parent

    function isurl(s) {/*
        var strRegex = "^((https|http|ftp|rtsp|mms)?://)"
            + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp user@
            + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP 99.194.52.184
            + "|" // DOMAIN
            + "([0-9a-z_!~*'()-]+\.)*" //  www.
            + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 
            + "[a-z]{2,6})" // first level domain- .com or .museum
            + "(:[0-9]{1,4})?" // :80
            + "((/?)|" // a slash isn't required if there is no file name
            + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";
         var re=new RegExp(strRegex);
         return re.test(url);*/
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
/*
    function geturl(text) {
        let newUrl = decodeURIComponent(text);
        newUrl = newUrl.trim().replace(/\s/g, "");

        if(/^(:\/\/)/.test(newUrl)){
            return `http${newUrl}`;
        }
        if(!/^(f|ht)tps?:\/\//i.test(newUrl)){
            return `http://${newUrl}`;
        }

        return newUrl;
    }*/

    property string urltogo: ""

    header: PageHeader {
        id: pageHeader
        anchors.top: parent.top
            //anchors.top: preferences.adrpos === 1 ? parent.top  :  undefined
            //anchors.bottom: preferences.adrpos === 1 ? parent.bottom  :  undefined
            //bottom: parent.bottom
            /*State {
                name: "anchorBottom"
                AnchorChanges {
                    target: pageHeader
                    anchors.top: undefined  //remove the top anchor
                    anchors.bottom: parent.bottom
                }
            }*/
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
        	placeholderText: i18n.tr('Enter website here')
            inputMethodHints: {
                Qt.ImhNoAutoUppercase,
                Qt.ImhUrlCharactersOnly,
                Qt.ImhNoPredictiveText
            }
            onAccepted: {
                webview.url = geturl(textFieldInput.text),
                //urltogo = geturl(textFieldInput.text),
                //urltogo = textFieldInput.text
                webview.url = urltogo,
                webview.visible = true,
                webview.stop(),
                webview.reload()
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
        anchors {/*
            top: pageHeader.bottom
            topMargin: units.gu(0)
            left: parent.left
            right: parent.right
	        rightMargin: units.gu(0)
            bottom: parent.bottom
        }/*
        State {
        name: "anchorBottom"
            AnchorChanges {
                target: webview
                anchors.top: parent.top
                anchors.bottom: pageHeader.top
            }
        }
       
            top: parent.top
        	topMargin: units.gu(0)
            left: parent.left
            bottom: pageHeader.top
            right: parent.right
	        rightMargin: units.gu(0)
        }*/
            top: pageHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        	topMargin: units.gu(0)
	        rightMargin: units.gu(0)
        }
        url: urltogo
        zoomFactor: preferences.zoomlevel / 100
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
/*
    Component.onCompleted: {
        webview.stop()
    }*/
}
