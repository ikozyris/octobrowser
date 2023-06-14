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
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.2
import Ubuntu.Components 1.3
import Qt.labs.settings 1.0
import Qt.labs.platform 1.1
import QtWebEngine 1.10
import Ubuntu.Components.Popups 1.3
//import Ubuntu.PerformanceMetrics 0.1
import Ubuntu.Content 1.3

MainView {
//ApplicationWindow { //for engine
    id: mainView
    applicationName: 'octobrowser.ikozyris'
    automaticOrientation: true
    anchorToKeyboard: false
    //visible: true //for engine
    width: units.gu(45)
    height: units.gu(75)

    Settings {
        id: prefs
        property int zoomlevel: 100
        property int adrpos: 0
        // TODO: better UA?
        property string cmuseragent: "Mozilla/5.0 (Linux; Mobile; Ubuntu 16.04 like Android 9;) AppleWebKit/537.36 Chrome/87.0.4280.144 Mobile Safari/537.36"
        property bool js: true
        property bool loadimages: true
        property bool securecontent: false
        property bool webrtc: false
        property bool keeptabs: false
        property bool autoplay: false
        property bool lightfilter: false
        property bool clearcache: false
    }

    // Maybe use a DB?
    Settings {
        id: history
        property var urls: [""]
        property var dates: [""]
        // since urls.lenght does not work, custom counter is used
        property int count: 0
    }

    KeyboardRectangle {
        id: keyboardRect
    }

    PageStack {
        id: pStack
        anchors {
            fill: undefined // unset the default to make the other anchors work
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: keyboardRect.top
        }
    }
/*
    PerformanceOverlay {
        anchors.fill: pStack
        enabled: true
    }*/
    ColorOverlay { //blue light filter
        anchors.fill: pStack
        source: pStack
        visible: prefs.lightfilter
// TODO: better ARGB (3/16 opacity) #AARRGGBB (like SVG khaki without blue)
        color: "#30f0e600"
    }
    // TODO: find a way to make both effects work (color + brightness)
    /*
    BrightnessContrast {
        anchors.fill: pStack
        source: pStack
        visible: prefs.lightfilter
        brightness: -0.25
    }*/

    WebEngineProfile {
        //for more profile options see https://doc.qt.io/qt-5/qml-qtwebengine-webengineprofile.html
        id: webViewProfile
        storageName: "OctoStorage"

        // wrong path
        //persistentStoragePath: StandardPaths.writableLocation(StandardPaths.AppDataLocation)
        //StandardPaths.writableLocation(StandardPaths.AppDataLocation) + "/Downloads"
        downloadPath: "/home/phablet/.local/share/octobrowser.ikozyris/Downloads/"
        
        httpCacheMaximumSize: 90000000 // 90MB

        httpUserAgent: prefs.cmuseragent;                        //custom UA
        offTheRecord: false
        onDownloadRequested: {/*
            console.log(download.url)
            var fileUrl = StandardPaths.writableLocation(StandardPaths.AppDataLocation)
                 + "/Downloads/" + download.downloadFileName;
            //var fileUrl = "/home/phablet/.local/share/octobrowser.ikozyris/Downloads/"
                 + download.downloadFileName;
            var request = new XMLHttpRequest();
            request.open("PUT", fileUrl, false);
            request.send(decodeURIComponent(download.url.toString().replace("data:text/plain;,", "")))*/
            download.accept()
            PopupUtils.open(Qt.resolvedUrl("/qml/Dialogs/Download.qml"), 
            null, {'downloadItem': download})
            //console.log("downloading to: " + webViewProfile.downloadPath + download.downloadFileName)
        }
    }
    Loader {
        id: contentPickerLoader
        source: Qt.resolvedUrl("/qml/Content/Picker.qml")
        active: false
        asynchronous: true
    }

    // if it was trigerred internally
    property bool internal: false
    Connections {
        target: ContentHub

        onImportRequested: {
            console.log("import")
            console.log(transfer)
            // it was triggered externally so open it in webview
            if (!internal) {
                MyTabs.currtab = transfer.items[0].url
                MyTabs.tabVisibility = true
            }

        }
        onExportRequested: {
            console.log("export")
        }
    }
    Component.onCompleted: {
        console.log(Date())
        //console.log(StandardPaths.writableLocation(StandardPaths.AppDataLocation) + "/Downloads/")
        //console.log(StandardPaths.writableLocation(StandardPaths.downloadLocation) + "/Downloads/")
        //console.log(webViewProfile.downloadPath)
        // WORKAROUND: since app closes before onDestruction 
        if (prefs.clearcache) {
            //console.log("clearing cache")
            webViewProfile.clearHttpCache()
        }
        pStack.push(Qt.resolvedUrl("MainPage.qml"))
    }
}
