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
import "qrc:///qml/Utils.js" as JS

WebEngineView {
    id: webview
    visible: MyTabs.tabVisibility
    url: MyTabs.currtab
    zoomFactor: prefs.zoomlevel / 100                    // custom zoom factor
    backgroundColor: "lightgrey"

    settings {
        javascriptEnabled: prefs.js                      // enable javascipt
        autoLoadImages: prefs.loadimages                 // autoload images
        webRTCPublicInterfacesOnly: prefs.webrtc         // setting to true creates leaks
        pluginsEnabled: true                             // for pdf
        pdfViewerEnabled: true                           // enable pdf viewer
        // according to: https://sites.google.com/a/chromium.org/dev/audio-video/autoplay
        playbackRequiresUserGesture: prefs.autoplay      // block autoplay (chrome behavior)
        // TODO: show a more mobile-friendly, smaller and nicer scrollbar
        showScrollBars: false                            // do not show scroll bars
        allowRunningInsecureContent: prefs.securecontent // inSecure content
        fullScreenSupportEnabled: true
        dnsPrefetchEnabled: true
        touchIconsEnabled: true
        localStorageEnabled: true
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
    onUrlChanged: {
        MyTabs.tabs[MyTabs.tabNum] = webview.url
        pageHeader.textbar = webview.url
    }
    onLoadingChanged: {
        // TODO: display with popup
        if (loadRequest.errorString)
            console.error(loadRequest.errorString)
        else {
            // avoid duplicates
            if (history.urls[history.count] !== url) {
                //add url to history
                history.urls.push(webview.url)
                history.dates.push(new Date())
                history.count = history.count + 1
            }
        }
    }

    // html <select> override
    property var selectOverride: function(request) {
        var dialog = PopupUtils.open(Qt.resolvedUrl("Dialogs/SelectOverride.qml"), this);
        dialog.options = request.defaultText;
        dialog.accept.connect(request.dialogAccept);
        dialog.reject.connect(request.dialogReject);
        //make sure to close dialogs after returning a value ( fix freeze with big dropdowns )
        dialog.accept.connect(function() { PopupUtils.close(dialog) })
        dialog.reject.connect(function() { PopupUtils.close(dialog) })
    }
    readonly property var isASelectRequest: function(request){
        return (request.type === JavaScriptDialogRequest.DialogTypePrompt && request.message==='XX-MORPH-SELECT-OVERRIDE-XX');
    }
    userScripts: WebEngineScript {
        runOnSubframes: true
        sourceUrl: Qt.resolvedUrl("select_override.js")
        injectionPoint: WebEngineScript.DocumentReady
        worldId: WebEngineScript.MainWorld
    }
    onJavaScriptDialogRequested: function(request) {
        if (isASelectRequest(request)) {
            request.accepted = true;
            selectOverride(request);
        }
    }
    onFileDialogRequested: function(request) {
        switch (request.mode) {
            case FileDialogRequest.FileModeOpen:
                request.accepted = true;
                var fileDialogSingle = PopupUtils.open(Qt.resolvedUrl("Content/Picker.qml"));
                fileDialogSingle.allowMultipleFiles = false;
                fileDialogSingle.accept.connect(request.dialogAccept);
                fileDialogSingle.reject.connect(request.dialogReject);
                break;

            case FileDialogRequest.FileModeOpenMultiple:
                request.accepted = true;
                var fileDialogMultiple = PopupUtils.open(Qt.resolvedUrl("Content/Picker.qml"));
                fileDialogMultiple.allowMultipleFiles = true;
                fileDialogMultiple.accept.connect(request.dialogAccept);
                fileDialogMultiple.reject.connect(request.dialogReject);
                break;

            //case FilealogRequest.FileModeUploadFolder:
            case FileDialogRequest.FileModeSave:
                request.accepted = false;
                break;
        }
    }

    onNavigationRequested: function(request) {
        request.action = WebEngineNavigationRequest.AcceptRequest;
    }
    onNewViewRequested: function(request) {
        JS.newtab();
        MyTabs.currtab = request.requestedUrl;
        MyTabs.tabVisibility = true;
    }
    onFindTextFinished: function(result) {
        Find.totalFound = result.numberOfMatches;
        Find.activeFound = result.activeMatch;
    }
}
