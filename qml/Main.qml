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
import QtWebEngine 1.11
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
        // General
        property int zoomlevel: 100
        property int adrpos: 0
        property int srchEngine: 0
        property bool keeptabs: false
        //property bool padding: false
        property bool clearcache: false
        property bool dim: false
        property bool nightMode: false
        property bool lightfilter: false
        property bool ac: true

        // Security & Privacy
        // TODO: better UA?
        property string cmuseragent: "Mozilla/5.0 (Linux; Mobile; Ubuntu 16.04 like Android 9) AppleWebKit/537.36 Chrome/87.0.4280.144 Mobile Safari/537.36"
        property bool js: true
        property bool loadimages: true
        property bool securecontent: false
        property bool webrtc: false
        property bool autoplay: false

        // Advanced
        property bool dark: false
        property bool scrollbar: true
        property bool lowend: false
        property bool smoothscroll: true
        property bool log: true
        property int download: 0 // WebView 0 or SingleDownload 1
    }

    // Maybe use a DB? like SQLite?
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
            fill: undefined // unset to make the other anchors work
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: keyboardRect.top
        }
    }

/*    PerformanceOverlay {
        id: perf
        z: 100
        anchors.fill: pStack
        enabled: true
    }*/

    // TODO: find a way to make all effects work at the same time
    Loader {
        anchors.fill: pStack
        active: prefs.lightfilter
        asynchronous: true
        sourceComponent: ColorOverlay { //blue light filter
            source: pStack
    // TODO: better ARGB (3/16 opacity) (like SVG khaki without blue)
            //      #AARRGGBB
            color: "#30f0e600"
        }
    }
    Loader {
        anchors.fill: pStack
        active: prefs.dim
        sourceComponent: BrightnessContrast {
            source: pStack
            brightness: -0.25
        }
    }


    WebEngineProfile {
        //for more profile options see https://doc.qt.io/qt-5/qml-qtwebengine-webengineprofile.html
        id: webViewProfile
        storageName: "OctoStorage"

        // wrong path
        //persistentStoragePath: StandardPaths.writableLocation(StandardPaths.AppDataLocation)
        //StandardPaths.writableLocation(StandardPaths.AppDataLocation) + "/Downloads"
        downloadPath: "/home/phablet/.local/share/octobrowser.ikozyris/Downloads/"
        
        httpCacheMaximumSize: 94371840 // ~90MB

        httpUserAgent: prefs.cmuseragent
        offTheRecord: false
        onDownloadRequested: {
            if (prefs.download === 0) {
                download.accept()
                PopupUtils.open(Qt.resolvedUrl("/qml/Dialogs/Download.qml"), 
                null, {'downloadItem': download})
            } else {
                PopupUtils.open(Qt.resolvedUrl("/qml/Dialogs/DownloadSingle.qml"), 
                null, {'downloadItem': download})
            }
            //console.log("downloading to: " + webViewProfile.downloadPath + download.downloadFileName)
        }
    }

    // if it was trigerred internally
    property bool internal: false
    Connections {
        target: ContentHub

        onImportRequested: {
            console.log("import")
            //console.log(transfer)
            // it was triggered externally so open it in webview
            if (!internal) {
                MyTabs.currtab = transfer.items[0].url
                MyTabs.tabVisibility = true
            } /*else {
                console.log("internal import")
            }*/

        }
        onExportRequested: {
            console.log("export")
        }
    }
    Component.onCompleted: {
        //console.log(Date())
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
