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

import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtWebEngine 1.11
import QtQuick 2.12

WebEngineView {
    id: webview
    visible: MyTabs.tabVisibility
    url: /*MyTabs.tabs[MyTabs.tabNum] */MyTabs.currtab
    zoomFactor: prefs.zoomlevel / 100                    // custom zoom factor

    settings {
        javascriptEnabled: prefs.js                      // enable javascipt
        autoLoadImages: prefs.loadimages                 // autoload images
        webRTCPublicInterfacesOnly: prefs.webrtc         // setting to true creates leaks
        pluginsEnabled: true                             // for pdf
        pdfViewerEnabled: true                           // enable pdf viewer
        // according to: https://sites.google.com/a/chromium.org/dev/audio-video/autoplay
        playbackRequiresUserGesture: prefs.autoplay      // autoplay video (chrome behavior)
        showScrollBars: false                            // do not show scroll bars
        allowRunningInsecureContent: prefs.securecontent // InSecure content
        fullScreenSupportEnabled: true
        dnsPrefetchEnabled: true
        touchIconsEnabled: true
    }
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
        MyTabs.display = webview.url
        MyTabs.tabs[MyTabs.tabNum] = webview.url
        //console.log("webview| " + MyTabs.tabs[MyTabs.tabNum])
        //console.log("webview| actual: " + webview.url) 
        //pageHeader.textFieldInput.text = webview.url
        if(loadRequest.errorString)
            console.error(loadRequest.errorString)
        else {
            history.urls.push(webview.url)
            history.dates.push(new Date())
            history.count = history.count + 1
        }
    }
    /**
    *   html select override
    *   set enableSelectOverride to true to make Morph.Web handle select
    *   note that as it uses javascript prompt,
    *   make sure that onJavaScriptDialogRequested signal handler don't overplay prompt dialog by checking the isASelectRequest(request)
    */

    property bool enableSelectOverride: true
    property var selectOverride: function(request) {
        console.log("test var")
        var dialog = PopupUtils.open(Qt.resolvedUrl("Dialogs/SelectOverride.qml"), this);
        dialog.options = request.defaultText;
        dialog.accept.connect(request.dialogAccept);
        dialog.reject.connect(request.dialogReject);
        //make sure to close dialogs after returning a value ( fix freeze with big dropdowns )
        dialog.accept.connect(function() { PopupUtils.close(dialog) })
        dialog.reject.connect(function() { PopupUtils.close(dialog) })
    }
    readonly property var isASelectRequest: function(request){
        return (request.type === JavaScriptDialogRequest.DialogTypePrompt && request.message==='XX-MORPH-SELECT-OVERRIDE-XX')
    }

    userScripts: WebEngineScript {
        runOnSubframes: true
        sourceUrl: enableSelectOverride ? Qt.resolvedUrl("select_override.js") : ""
        injectionPoint: WebEngineScript.DocumentReady
        worldId: WebEngineScript.MainWorld
    }

    onJavaScriptDialogRequested: function(request) {
        console.log("test request")
        //if (isASelectRequest(request)) return; //this is a select box , Morph.Web handled it already
        if (enableSelectOverride && isASelectRequest(request)) {
            request.accepted = true
            selectOverride(request)
        }
    }
    //onLoadProgressChanged: console.log(loadProgress)
    //onLinkChanged: webview.url = link
    backgroundColor: "lightgrey"
}
