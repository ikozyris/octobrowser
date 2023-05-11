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
import QtWebEngine 1.11
import QtQuick 2.12

WebEngineView {
    id: webview
    visible: MyTabs.tabVisibility
    url: MyTabs.currtab
    zoomFactor: prefs.zoomlevel / 100                    // custom zoom factor

    settings {
        javascriptEnabled: prefs.js                      // enable javascipt
        autoLoadImages: prefs.loadimages                 // autoload images
        webRTCPublicInterfacesOnly: prefs.webrtc         // setting to true creates leaks
        pluginsEnabled: true                             // for pdf
        playbackRequiresUserGesture: prefs.autoplay      // autoplay video (chrome behavior)
        pdfViewerEnabled: true                           // enable pdf viewer
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
        //pageHeader.textFieldInput.text = webview.url
        MyTabs.currtab = webview.url
        if(loadRequest.errorString)
            console.error(loadRequest.errorString)
        else {
            history.urls.push(webview.url)
            history.dates.push(new Date())
            history.count = history.count + 1
        }
    }
    backgroundColor: "grey"
}
